return {
	"https://github.com/rebelot/kanagawa.nvim",
	opts = {
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
				["@lsp.typemod.function.readonly"] = { bold = false },
				["@string.escape"] = { bold = false },
				["@string.special.url"] = {
					fg = colors.theme.syn.special1,
					undercurl = false,
					underline = true,
				},
				["@variable.builtin"] = { italic = false },
			}
		end,
	},
	config = function(_, opts)
		require("kanagawa").setup(opts)
		vim.cmd.colorscheme({
			args = { "kanagawa" },
		})
	end,
}
