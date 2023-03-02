return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"folke/neodev.nvim",
	},
	config = function()
		require("neodev").setup()

		local lspconfig = require("lspconfig")
		local on_attach = require("lsp.on_attach")
		require("mason-lspconfig").setup_handlers({
			function(server_name)
				lspconfig[server_name].setup({
					on_attach = on_attach,
				})
			end,
			["lua_ls"] = function()
				lspconfig.lua_ls.setup({
					on_attach = on_attach,
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
			end,
		})
	end,
}
