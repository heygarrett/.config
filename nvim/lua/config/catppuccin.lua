return {
	"catppuccin/nvim",
	as = "catppuccin",
	config = function()
		local loaded, catppuccin = pcall(require, "catppuccin")
		if not loaded then return end

		local palette = require("catppuccin.palettes").get_palette()
		catppuccin.setup({
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
