return {
	"https://github.com/rebelot/kanagawa.nvim",
	config = function()
		require("kanagawa").setup({
			commentStyle = { italic = false },
			keywordStyle = { italic = false },
			statementStyle = { bold = false },
			colors = {
				theme = { all = { ui = { bg_gutter = "none" } } },
			},
			overrides = function(colors)
				return {
					Boolean = { bold = false },
					CursorLineNr = { fg = colors.palette.lightBlue },
					["@keyword.operator"] = { bold = false },
					["@keyword.return"] = { fg = colors.theme.syn.keyword },
					["@variable.builtin"] = { italic = false },
				}
			end,
		})
		vim.cmd.colorscheme({
			args = { "kanagawa" },
		})
	end,
}
