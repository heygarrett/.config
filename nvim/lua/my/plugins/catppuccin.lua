return {
	"https://github.com/catppuccin/nvim",
	name = "catppuccin",
	opts = {
		flavor = "mocha",
		custom_highlights = function(colors)
			return {
				LineNr = { fg = colors.surface2 },
			}
		end,
		styles = {
			comments = {},
			conditionals = {},
			miscs = {},
		},
	},
	config = function(_, opts)
		require("catppuccin").setup(opts)
		vim.cmd.colorscheme({ args = { "catppuccin" } })
	end,
}
