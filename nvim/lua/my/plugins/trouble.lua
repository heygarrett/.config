local trouble = function() return require("trouble") end

return {
	"https://github.com/folke/trouble.nvim",
	lazy = true,
	keys = {
		{
			"<leader>q",
			function() trouble().toggle() end,
			mode = { "n" },
			desc = "trouble: toggle diagnostics",
		},
	},
	opts = {
		mode = "document_diagnostics",
		icons = false,
	},
}
