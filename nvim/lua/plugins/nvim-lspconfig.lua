return {
	"neovim/nvim-lspconfig",
	dependencies = "folke/neodev.nvim",
	lazy = false,
	config = function()
		require("neodev").setup()

		local servers = {
			"bashls",
			"dockerls",
			"jsonls",
			"marksman",
			"pyright",
			"rust_analyzer",
			"sourcekit",
			"tsserver",
			"vimls",
			"yamlls",
		}

		local lspconfig = require("lspconfig")
		local on_attach = require("lsp.on_attach")
		for _, s in ipairs(servers) do
			lspconfig[s].setup({
				on_attach = on_attach,
			})
		end

		lspconfig.sumneko_lua.setup({
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
}
