local snippy = function() return require("snippy") end

return {
	"https://github.com/dcampos/nvim-snippy",
	lazy = true,
	init = function()
		vim.api.nvim_create_autocmd("CompleteDone", {
			desc = "set up nvim-snippy",
			group = vim.api.nvim_create_augroup("snippy", { clear = true }),
			callback = function() snippy().complete_done() end,
		})
	end,
	config = function()
		snippy().setup({
			mappings = {
				is = {
					["<tab>"] = "next",
					["<s-tab>"] = "previous",
				},
			},
		})
	end,
}
