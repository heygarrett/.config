local snippy = function() return require("snippy") end

return {
	"https://github.com/dcampos/nvim-snippy",
	lazy = true,
	init = function()
		local group = vim.api.nvim_create_augroup("snippy", { clear = true })
		vim.api.nvim_create_autocmd("CompleteDone", {
			desc = "set up nvim-snippy",
			group = group,
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
