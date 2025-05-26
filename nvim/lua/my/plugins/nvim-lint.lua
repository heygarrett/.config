local nvim_lint = function()
	return require("lint")
end

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

return {
	"https://github.com/mfussenegger/nvim-lint",
	init = function()
		local group = vim.api.nvim_create_augroup("nvim-lint", { clear = true })
		vim.api.nvim_create_autocmd("FileType", {
			desc = "nvim-lint",
			group = group,
			pattern = vim.tbl_keys(linters_by_filetype),
			callback = function(event_opts)
				vim.api.nvim_create_autocmd({
					"BufWinEnter",
					"BufWritePost",
					"InsertLeave",
					"TextChanged",
				}, {
					desc = "nvim-lint",
					group = group,
					buffer = event_opts.buf,
					callback = function()
						nvim_lint().try_lint(nil, { ignore_errors = true })
					end,
				})
			end,
		})
	end,
	config = function()
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

			nvim_lint().linters_by_ft[filetype] = resolved_linters
		end
	end,
}
