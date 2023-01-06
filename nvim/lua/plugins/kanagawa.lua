return {
	"rebelot/kanagawa.nvim",
	lazy = false,
	config = function()
		local default_colors = require("kanagawa.colors").setup()
		local overrides = {
			CursorLineNR = { fg = default_colors.lightBlue },
		}
		require("kanagawa").setup({
			overrides = overrides,
			commentStyle = {},
			keywordStyle = {},
			statementStyle = {},
			variablebuiltinStyle = {},
			specialReturn = false,
		})
		vim.cmd.colorscheme({
			args = { "kanagawa" },
		})
	end,
}
