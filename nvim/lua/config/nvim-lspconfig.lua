return {
	"neovim/nvim-lspconfig",
	config = function()
		require("lsp.diagnostics")
		require("lsp.sumneko_lua")

		local nvim_lsp = require("lspconfig")
		local on_attach = require("lsp.on_attach")

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
			nvim_lsp[lsp].setup({
				on_attach = on_attach,
			})
		end
	end,
}
