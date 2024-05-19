return {
	"https://github.com/neovim/nvim-lspconfig",
	dependencies = { "https://github.com/folke/neodev.nvim" },
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
							hint = {
								enable = true,
								-- ---@type "Auto" | "Enable" | "Disable"
								-- arrayIndex = "Auto",
								-- await = true,
								-- ---@type "All" | "Literal" | "Disable"
								-- paramName = "All",
								-- paramType = true,
								-- ---@type "All" | "SameLine" | "Disable"
								-- semicolon = "SameLine",
								-- setType = false,
							},
						},
					},
				})
			end,
			rust_analyzer = function()
				lspconfig.rust_analyzer.setup({
					settings = {
						["rust-analyzer"] = {
							rust = {
								analyzerTargetDir = true,
							},
							checkOnSave = {
								command = "clippy",
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
					on_attach = function(client)
						-- stylua: ignore
						client.server_capabilities.documentFormattingProvider = false
					end,
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
				local biome_paths = vim.fs.find("biome.json", { upward = true })
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
