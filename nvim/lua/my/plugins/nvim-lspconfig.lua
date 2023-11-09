return {
	"https://github.com/neovim/nvim-lspconfig",
	branch = "master",
	dependencies = {
		"https://github.com/folke/neodev.nvim",
	},
	config = function()
		require("neodev").setup()

		local lspconfig = require("lspconfig")
		require("mason-lspconfig").setup_handlers({
			-- Mason language servers with default setups
			function(server_name) lspconfig[server_name].setup({}) end,

			-- Mason language servers with custom setups
			lua_ls = function()
				lspconfig.lua_ls.setup({
					settings = {
						Lua = {
							workspace = { checkThirdParty = false },
						},
					},
				})
			end,
			pylsp = function()
				lspconfig.pylsp.setup({
					settings = {
						pylsp = {
							plugins = {
								autopep8 = {
									-- disable formatting
									enabled = false,
								},
								pycodestyle = {
									-- allow tabs for indentation
									ignore = { "W191" },
								},
							},
						},
					},
				})
			end,
			tsserver = function()
				lspconfig.tsserver.setup({
					init_options = {
						-- prevent omni completion from inserting extra period
						completionDisableFilterText = true,
					},
				})
			end,
			yamlls = function()
				lspconfig.yamlls.setup({
					settings = {
						yaml = { keyOrdering = false },
					},
				})
			end,
		})

		-- Non-Mason language servers
		lspconfig.hls.setup({
			settings = {
				haskell = { formattingProvider = "fourmolu" },
			},
		})
		lspconfig.sourcekit.setup({
			root_dir = require("lspconfig.util").root_pattern(
				"Package.swift",
				"*.xcodeproj",
				".git"
			),
		})
	end,
}
