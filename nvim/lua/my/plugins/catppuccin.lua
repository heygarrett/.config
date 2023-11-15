return {
	"https://github.com/catppuccin/nvim",
	name = "catppuccin",
	config = function()
		require("catppuccin").setup({
			flavour = "mocha",
			styles = {
				comments = {},
				conditionals = {},
			},
		})
		vim.cmd.colorscheme({
			args = { "catppuccin" },
		})
	end,
}
