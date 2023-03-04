return {
	"rebelot/kanagawa.nvim",
	config = function()
		require("kanagawa").setup({
			commentStyle = { italic = false },
			keywordStyle = { italic = false },
			colors = {
				theme = { all = { ui = { bg_gutter = "none" } } },
			},
			overrides = function(colors)
				return {
					CursorLineNr = { fg = colors.palette.lightBlue },
					["@keyword.return"] = { fg = colors.theme.syn.keyword },
				}
			end,
		})
		vim.cmd.colorscheme({
			args = { "kanagawa" },
		})
	end,
}
