return {
	"rebelot/kanagawa.nvim",
	lazy = false,
	config = function()
		require("kanagawa").setup({
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
