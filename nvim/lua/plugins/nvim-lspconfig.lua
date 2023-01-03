return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"folke/neodev.nvim",
		"VonHeikemen/lsp-zero.nvim",
	},
	lazy = false,
	config = function()
		require("neodev").setup()

		local lsp_zero = require("lsp-zero")
		lsp_zero.set_preferences({
			suggest_lsp_servers = true,
			setup_servers_on_start = true,
			set_lsp_keymaps = false,
			call_servers = "local",
		})
		lsp_zero.on_attach(require("lsp.on_attach"))
		lsp_zero.configure("sumneko_lua", {
			settings = {
				Lua = {
					completion = {
						callSnippet = "Replace",
					},
					workspace = {
						checkThirdParty = false,
					},
					telemetry = {
						enable = false,
					},
				},
			},
		})
		lsp_zero.setup()
	end,
}
