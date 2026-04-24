vim.pack.add({ "https://github.com/mfussenegger/nvim-lint" })

local nvim_lint = function()
	return require("lint")
end

---@param bufnr integer
---@return string?
local actionlint = function(bufnr)
	local buf_name = vim.api.nvim_buf_get_name(bufnr)
	for dir in vim.fs.parents(buf_name) do
		if vim.endswith(dir, ".github/workflows") then
			return "actionlint"
		end
	end

	return nil
end

---@param _ integer
---@return string?
local commitlint = function(_)
	local config_exists = next(vim.fs.find(function(name)
		return name:match("commitlint") ~= nil
	end, { upward = true, limit = 1 }))

	return config_exists and "commitlint"
end

---@type table<string, (string|function)[]>
local linters_by_filetype = setmetatable({
	env = { "dotenv_linter" },
	fish = { "fish" },
	html = { "htmlhint" },
	jjdescription = { commitlint },
	yaml = { actionlint },
}, {
	__index = function()
		return {}
	end,
})

---@param bufnr integer
---@return string[]
local get_linters = function(bufnr)
	local buf_filetype = vim.bo[bufnr].filetype
	local filetype_linters = linters_by_filetype[buf_filetype]

	return vim.iter(filetype_linters)
		:map(
			---@param linter string | function
			function(linter)
				if type(linter) == "function" then
					return linter(bufnr)
				else
					return linter
				end
			end
		)
		:totable()
end

local group = vim.api.nvim_create_augroup("nvim-lint", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	desc = "nvim-lint",
	group = group,
	callback = function(filetype_event_opts)
		if vim.bo[filetype_event_opts.buf].buftype ~= "" then
			return
		end

		vim.api.nvim_create_autocmd({
			"BufWinEnter",
			"BufWritePost",
			"InsertLeave",
			"TextChanged",
		}, {
			desc = "nvim-lint",
			group = group,
			buffer = filetype_event_opts.buf,
			callback = function(lint_event_opts)
				nvim_lint().try_lint("editorconfig-checker")
				nvim_lint().try_lint(
					get_linters(lint_event_opts.buf),
					{ ignore_errors = true }
				)
			end,
		})
	end,
})
