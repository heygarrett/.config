local linters_by_filetype = {
	fish = { "fish" },
}

return {
	"https://github.com/mfussenegger/nvim-lint",
	lazy = true,
	ft = vim.tbl_keys(linters_by_filetype),
	config = function()
		local nvim_lint = require("lint")

		for filetype, linters in pairs(linters_by_filetype) do
			---@type string[]
			local available_linters = {}
			for _, linter in ipairs(linters) do
				if vim.fn.executable(nvim_lint.linters[linter].cmd) == 1 then
					table.insert(available_linters, linter)
				end
			end
			nvim_lint.linters_by_ft[filetype] = available_linters
		end

		local group = vim.api.nvim_create_augroup("nvim-lint", { clear = true })
		vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave", "TextChanged" }, {
			desc = "nvim-lint",
			group = group,
			callback = function()
				nvim_lint.try_lint()
			end,
		})
	end,
}
