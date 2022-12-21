return {
	"neovim/nvim-lspconfig",
	dependencies = { "folke/neodev.nvim" },
	config = function()
		local lspconfig_loaded, lspconfig = pcall(require, "lspconfig")
		if not lspconfig_loaded then return end

		local servers = {
			"bashls",
			"dockerls",
			"jsonls",
			"marksman",
			"pyright",
			"rust_analyzer",
			"solargraph",
			"sourcekit",
			"tsserver",
			"vimls",
			"yamlls",
		}

		local on_attach = require("lsp.on_attach")
		for _, s in ipairs(servers) do
			lspconfig[s].setup({
				on_attach = on_attach,
			})
		end

		local neodev_loaded, neodev = pcall(require, "neodev")
		if not neodev_loaded then return end

		neodev.setup()
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