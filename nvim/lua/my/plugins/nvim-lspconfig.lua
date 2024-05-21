return {
	"https://github.com/neovim/nvim-lspconfig",
	dependencies = { "https://github.com/folke/neodev.nvim" },
	config = function()
		require("neodev").setup()

		local lspconfig = require("lspconfig")

		require("mason-lspconfig").setup_handlers({
			-- Mason language servers with default setups
			function(server_name) lspconfig[server_name].setup({}) end,

			-- Mason language servers with custom setups
			gopls = function()
				lspconfig.gopls.setup({
					settings = {
						gopls = {
							hints = {
								-- assignVariableTypes = true,
								compositeLiteralFields = true,
								compositeLiteralTypes = true,
								constantValues = true,
								functionTypeParameters = true,
								parameterNames = true,
								rangeVariableTypes = true,
							},
						},
					},
				})
			end,
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
							inlayHints = {
								-- bindingModeHints = { enable = false },
								-- chainingHints = { enable = true },
								-- closingBraceHints = {
								-- 	enable = true,
								-- 	minLines = 25,
								-- },
								-- closureCaptureHints = { enable = false },
								-- closureReturnTypeHints = { enable = "never" },
								-- closureStyle = "impl_fn",
								-- discriminantHints = { enable = "never" },
								-- expressionAdjustmentHints = {
								-- 	enable = "never",
								-- 	hideOutsideUnsafe = false,
								-- 	mode = "prefix",
								-- },
								-- implicitDrops = { enable = false },
								-- lifetimeElisionHints = {
								-- 	enable = "never",
								-- 	useParameterNames = false,
								-- },
								-- maxLength = 25,
								-- parameterHints = { enable = true },
								-- rangeExclusiveHints = { enable = false },
								-- reborrowHints = { enable = never },
								-- renderColons = true,
								-- typeHints = {
								-- 	enable = true,
								-- 	hideClosureInitialization = false,
								-- 	hideNamedConstructor = false,
								-- },
							},
						},
					},
				})
			end,
			tsserver = function()
				lspconfig.tsserver.setup({
					init_options = {
						preferences = {
							includeInlayEnumMemberValueHints = true,
							-- includeInlayFunctionLikeReturnTypeHints = false,
							-- includeInlayFunctionParameterTypeHints = false,
							includeInlayParameterNameHints = "all",
							-- includeInlayParameterNameHintsWhenArgumentMatchesName = false,
							includeInlayPropertyDeclarationTypeHints = true,
							-- includeInlayVariableTypeHints = false,
							-- includeInlayVariableTypeHintsWhenTypeMatchesName = false,
						},
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
			single_file_support = false,
			root_dir = function()
				local root = vim.fs.root(0, { "package.json", "node_modules" })
				if not root then
					return nil
				end

				local binary = root .. "/node_modules/.bin/biome"
				local configs = vim.fs.find("biome.json", { upward = true })
				if
					vim.fn.executable(binary) ~= 1
					and vim.tbl_isempty(configs)
				then
					return nil
				end

				return root
			end,
		})
		lspconfig.hls.setup({
			settings = {
				haskell = { formattingProvider = "fourmolu" },
			},
		})
		lspconfig.sourcekit.setup({
			root_dir = function()
				return vim.fs.root(0, {
					"Package.swift",
					"*.xcodeproj",
					".git",
				})
			end,
		})
	end,
}
