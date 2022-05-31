return {
	"neovim/nvim-lspconfig",
	config = function()
		require("utils/diagnostics")
		require("utils/lua-language-server")

		local nvim_lsp = require("lspconfig")
		local on_attach = require("utils/on-attach")
		local capabilities = vim.lsp.protocol.make_client_capabilities()

		local servers = {
			"eslint",
			"jsonls",
			"pyright",
			"rust_analyzer",
			"sourcekit",
			"tsserver",
		}

		for _, lsp in ipairs(servers) do
			nvim_lsp[lsp].setup {
				on_attach = on_attach,
				capabilities = capabilities,
			}
		end
	end
}
