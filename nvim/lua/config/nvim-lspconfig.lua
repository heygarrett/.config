return {
	"neovim/nvim-lspconfig",
	config = function()
		local loaded, lspconfig = pcall(require, "lspconfig")
		if not loaded then return end

		require("lsp.diagnostics")

		local servers = {
			"bashls",
			"dockerls",
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
		lspconfig.sumneko_lua.setup({
			on_attach = on_attach,
			settings = {
				Lua = {
					runtime = {
						version = "LuaJIT",
					},
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						library = vim.api.nvim_get_runtime_file("", true),
					},
					telemetry = {
						enable = false,
					},
				},
			},
		})
	end,
}
