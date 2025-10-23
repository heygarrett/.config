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
	jjdescription = { commitlint },
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
			local resolved_linters = vim.iter(linters)
				:map(
					---@param linter string | function
					function(linter)
						if type(linter) == "function" then
							return linter()
						else
							return linter
						end
					end
				)
				:totable()

			nvim_lint().linters_by_ft[filetype] = resolved_linters
		end
	end,
}
