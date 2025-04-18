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
}

return {
	"https://github.com/mfussenegger/nvim-lint",
	ft = vim.tbl_keys(linters_by_filetype),
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
		vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave", "TextChanged" }, {
			desc = "nvim-lint",
			group = group,
			callback = function()
				nvim_lint.try_lint(nil, { ignore_errors = true })
			end,
		})
	end,
}
