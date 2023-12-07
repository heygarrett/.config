return {
	"https://github.com/neovim/nvim-lspconfig",
	dependencies = {
		"https://github.com/folke/neodev.nvim",
	},
	config = function()
		require("neodev").setup()

		local lspconfig = require("lspconfig")
		local util = require("lspconfig.util")

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
			vtsls = function()
				lspconfig.vtsls.setup({
					settings = {
						javascript = {
							format = { enable = false },
						},
						typescript = {
							format = { enable = false },
						},
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
		lspconfig.biome.setup({
			-- TODO: file issue to update default config
			cmd = { "node_modules/.bin/biome", "lsp-proxy" },
			root_dir = function(filename)
				local biome_paths = vim.fs.find("biome", {
					upward = true,
					type = "file",
					path = "./node_modules/.bin/",
				})
				if
					not next(biome_paths)
					or vim.fn.executable(biome_paths[1]) ~= 1
				then
					return nil
				end

				local find_root =
					util.root_pattern("package.json", "node_modules")
				return find_root(filename)
			end,
			single_file_support = false,
		})
		lspconfig.hls.setup({
			settings = {
				haskell = { formattingProvider = "fourmolu" },
			},
		})
		lspconfig.sourcekit.setup({
			root_dir = util.root_pattern(
				"Package.swift",
				"*.xcodeproj",
				".git"
			),
		})
	end,
}
