return {
	"neovim/nvim-lspconfig",
	config = function()
		require("lsp/diagnostics")
		require("lsp/lua-language-server")

		local nvim_lsp = require("lspconfig")
		local on_attach = require("lsp/on-attach")
		local capabilities = vim.lsp.protocol.make_client_capabilities()

		local servers = {
			"bashls",
			"jsonls",
			"pyright",
			"rust_analyzer",
			"sourcekit",
			"tsserver",
			"vimls",
		}

		for _, lsp in ipairs(servers) do
			nvim_lsp[lsp].setup {
				on_attach = on_attach,
				capabilities = capabilities,
			}
		end
	end
}
