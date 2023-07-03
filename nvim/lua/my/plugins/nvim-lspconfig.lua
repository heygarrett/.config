return {
	"https://github.com/neovim/nvim-lspconfig",
	branch = "master",
	dependencies = {
		"https://github.com/folke/neodev.nvim",
	},
	config = function()
		require("neodev").setup()

		local lspconfig = require("lspconfig")
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		require("mason-lspconfig").setup_handlers({
			-- Mason language servers with default setups
			function(server_name)
				lspconfig[server_name].setup({
					capabilities = capabilities,
				})
			end,

			-- Mason language servers with custom setups
			lua_ls = function()
				lspconfig.lua_ls.setup({
					capabilities = capabilities,
					settings = {
						Lua = {
							completion = { callSnippet = "Replace" },
							workspace = { checkThirdParty = false },
						},
					},
				})
			end,
			tsserver = function()
				lspconfig.tsserver.setup({
					capabilities = capabilities,
					init_options = {
						-- prevent omni completion from inserting extra period
						completionDisableFilterText = true,
					},
				})
			end,
			yamlls = function()
				lspconfig.yamlls.setup({
					capabilities = capabilities,
					settings = {
						yaml = { keyOrdering = false },
					},
				})
			end,
		})
	end,
}
