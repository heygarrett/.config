return {
	"catppuccin/nvim",
	name = "catppuccin",
	version = "*",
	lazy = false,
	config = function()
		local palette = require("catppuccin.palettes").get_palette()
		require("catppuccin").setup({
			flavour = "mocha",
			no_italic = true,
			color_overrides = {
				all = {
					surface1 = palette.surface2,
				},
			},
		})
		vim.cmd.colorscheme({
			args = { "catppuccin" },
		})
	end,
}
