return {
	"neovim/nvim-lspconfig",
	branch = "master",
	dependencies = {
		"folke/neodev.nvim",
	},
	config = function()
		require("neodev").setup()

		local lspconfig = require("lspconfig")
		require("mason-lspconfig").setup_handlers({
			function(server_name) lspconfig[server_name].setup({}) end,
			["lua_ls"] = function()
				lspconfig.lua_ls.setup({
					settings = {
						Lua = {
							completion = { callSnippet = "Replace" },
							workspace = { checkThirdParty = false },
						},
					},
				})
			end,
			["tsserver"] = function()
				lspconfig.tsserver.setup({
					init_options = {
						-- prevent omni completion from inserting extra period
						completionDisableFilterText = true,
					},
				})
			end,
			["yamlls"] = function()
				lspconfig.yamlls.setup({
					settings = {
						yaml = { keyOrdering = false },
					},
				})
			end,
		})
	end,
}
