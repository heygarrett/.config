return {
	"folke/tokyonight.nvim",
	config = function()
		vim.g.tokyonight_style = "night"
		vim.api.nvim_command([[colorscheme tokyonight]])
	end
}
