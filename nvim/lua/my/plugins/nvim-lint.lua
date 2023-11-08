local linters_by_ft = {
	fish = { "fish" },
}

---@type string[]
local filetypes = {}
for k, _ in pairs(linters_by_ft) do
	table.insert(filetypes, k)
end

return {
	"https://github.com/mfussenegger/nvim-lint",
	lazy = true,
	ft = filetypes,
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = linters_by_ft

		local group = vim.api.nvim_create_augroup("nvim-lint", { clear = true })
		vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
			desc = "nvim-lint",
			group = group,
			callback = function() lint.try_lint() end,
		})
	end,
}
