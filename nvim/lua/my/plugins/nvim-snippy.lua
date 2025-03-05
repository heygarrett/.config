return {
	"https://github.com/dcampos/nvim-snippy",
	init = function()
		local group = vim.api.nvim_create_augroup("snippy", { clear = true })
		vim.api.nvim_create_autocmd("CompleteDone", {
			desc = "set up nvim-snippy",
			group = group,
			callback = function()
				require("snippy").complete_done()
			end,
		})
	end,
	opts = {
		mappings = {
			is = {
				["<tab>"] = "next",
				["<s-tab>"] = "previous",
			},
		},
	},
}
