---@return string?
local commitlint = function()
	local config_exists = next(vim.fs.find(function(name)
		return name:match("commitlint") ~= nil
	end, { upward = true, limit = 1 }))

	return config_exists and "commitlint"
end

local linters_by_filetype = {
	fish = { "fish" },
	gitcommit = { commitlint },
	jjdescription = { commitlint },
	make = { "checkmake" },
}
---@type string[]
local lintable_filetypes = vim.tbl_keys(linters_by_filetype)

return {
	"https://github.com/mfussenegger/nvim-lint",
	ft = lintable_filetypes,
	config = function()
		local nvim_lint = require("lint")

		for filetype, linters in pairs(linters_by_filetype) do
			---@type string[]
			local resolved_linters = {}
			for _, linter in ipairs(linters) do
				if type(linter) == "function" then
					local potential_linter = linter()
					if not potential_linter then
						goto continue
					end
					linter = potential_linter
				end
				table.insert(resolved_linters, linter)
				::continue::
			end

			nvim_lint.linters_by_ft[filetype] = resolved_linters
		end

		local group = vim.api.nvim_create_augroup("nvim-lint", { clear = true })
		---@param bufnr integer
		local create_autocmd = function(bufnr)
			vim.api.nvim_create_autocmd(
				{ "BufWinEnter", "BufWritePost", "InsertLeave", "TextChanged" },
				{
					desc = "nvim-lint",
					group = group,
					buffer = bufnr,
					callback = function()
						nvim_lint.try_lint(nil, { ignore_errors = true })
					end,
				}
			)
		end

		for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
			if not vim.api.nvim_buf_is_loaded(bufnr) then
				goto continue
			end
			if not vim.tbl_contains(lintable_filetypes, vim.bo[bufnr].filetype) then
				goto continue
			end

			create_autocmd(bufnr)

			::continue::
		end

		vim.api.nvim_create_autocmd("FileType", {
			desc = "nvim-lint",
			group = group,
			pattern = lintable_filetypes,
			callback = function(event_opts)
				create_autocmd(event_opts.buf)
			end,
		})
	end,
}
