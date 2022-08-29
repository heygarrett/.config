return {
	"neovim/nvim-lspconfig",
	config = function()
		local loaded, lspconfig = pcall(require, "lspconfig")
		if not loaded then return end

		require("lsp.diagnostics")
		require("lsp.sumneko_lua")

		local servers = {
			"bashls",
			"jsonls",
			"pyright",
			"rust_analyzer",
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
	end,
}
