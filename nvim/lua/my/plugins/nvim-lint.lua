local nvim_lint = function()
	return require("lint")
end

---@param _ integer
---@return string?
local commitlint = function(_)
	local config_exists = next(vim.fs.find(function(name)
		return name:match("commitlint") ~= nil
	end, { upward = true, limit = 1 }))

	return config_exists and "commitlint"
end

local linters_by_filetype = {
	fish = { "fish" },
	jjdescription = { commitlint },
}

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

return {
	"https://github.com/mfussenegger/nvim-lint",
	init = function()
		local group = vim.api.nvim_create_augroup("nvim-lint", { clear = true })
		vim.api.nvim_create_autocmd("FileType", {
			desc = "nvim-lint",
			group = group,
			pattern = vim.tbl_keys(linters_by_filetype),
			callback = function(filetype_event_opts)
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
						nvim_lint().try_lint(
							get_linters(lint_event_opts.buf),
							{ ignore_errors = true }
						)
					end,
				})
			end,
		})
	end,
}
