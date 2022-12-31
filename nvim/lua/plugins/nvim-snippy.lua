local snippy = function() return require("snippy") end

return {
	"dcampos/nvim-snippy",
	keys = "<c-x><c-o>",
	init = function()
		vim.api.nvim_create_autocmd("CompleteDone", {
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
