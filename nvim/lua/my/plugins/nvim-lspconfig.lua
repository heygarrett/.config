return {
	"https://github.com/neovim/nvim-lspconfig",
	config = function()
		local lspconfig = require("lspconfig")
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities.textDocument.completion.completionItem.resolveSupport = {
			properties = { "additionalTextEdits" },
		}

		require("mason-lspconfig").setup_handlers({
			-- Mason language servers with default setups
			function(server_name)
				lspconfig[server_name].setup({
					capabilities = capabilities,
				})
			end,

			-- Mason language servers with custom setups
			basedpyright = function()
				lspconfig["basedpyright"].setup({
					capabilities = capabilities,
					settings = {
						basedpyright = {
							analysis = {
								diagnosticSeverityOverrides = {
									reportImplicitStringConcatenation = false,
								},
							},
						},
					},
				})
			end,
			biome = function()
				lspconfig["biome"].setup({
					capabilities = capabilities,
					on_new_config = function(config)
						if vim.fn.executable("node_modules/.bin/biome") == 1 then
							config.cmd = { "node_modules/.bin/biome", "lsp-proxy" }
						end
					end,
					root_dir = function(file)
						local biome_root =
							vim.fs.root(file, { "biome.json", "biome.jsonc" })
						if biome_root then
							local node_root =
								vim.fs.root(file, { "package.json", "node_modules" })
							return node_root or biome_root
						else
							return nil
						end
					end,
				})
			end,
			gopls = function()
				lspconfig["gopls"].setup({
					capabilities = capabilities,
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
				lspconfig["lua_ls"].setup({
					capabilities = capabilities,
					settings = {
						Lua = {
							hint = {
								enable = true,
								---@type "Auto" | "Enable" | "Disable"
								arrayIndex = "Disable",
								-- await = true,
								-- awaitPropagate = false,
								-- ---@type "All" | "Literal" | "Disable"
								-- paramName = "All",
								-- paramType = true,
								-- ---@type "All" | "SameLine" | "Disable"
								-- semicolon = "SameLine",
								setType = true,
							},
						},
					},
					on_init = function(client)
						local ok, workspace_folder =
							pcall(unpack, client.workspace_folders)
						if not ok then
							return
						end
						local path = workspace_folder.name
						if
							vim.uv.fs_stat(path .. "/.luarc.json")
							or vim.uv.fs_stat(path .. "/.luarc.jsonc")
						then
							return
						end

						client.config.settings.Lua =
							vim.tbl_deep_extend("force", client.config.settings.Lua, {
								runtime = { version = "LuaJIT" },
								workspace = {
									checkThirdParty = "Disable",
									library = {
										"${3rd}/luv/library",
										unpack(vim.api.nvim_get_runtime_file("", true)),
									},
								},
							})
					end,
					on_attach = function()
						-- https://github.com/LuaLS/lua-language-server/issues/1809
						vim.api.nvim_set_hl(0, "@lsp.type.comment", {})
					end,
				})
			end,
			ruff = function()
				lspconfig["ruff"].setup({
					capabilities = capabilities,
					on_attach = function(client)
						client.server_capabilities.hoverProvider = false
					end,
				})
			end,
			taplo = function()
				lspconfig["taplo"].setup({
					capabilities = capabilities,
					-- https://github.com/tamasfe/taplo/issues/580#issuecomment-2361679688
					root_dir = function()
						return vim.uv.cwd()
					end,
					on_attach = function(client)
						client.server_capabilities.documentFormattingProvider = false
					end,
				})
			end,
			ts_ls = function()
				lspconfig["ts_ls"].setup({
					capabilities = capabilities,
					root_dir = function(file)
						return vim.fs.root(
							file,
							{ "package.json", "tsconfig.json", "jsconfig.json" }
						)
					end,
					single_file_support = false,
					init_options = {
						preferences = {
							includeInlayEnumMemberValueHints = true,
							-- includeInlayFunctionLikeReturnTypeHints = false,
							-- includeInlayFunctionParameterTypeHints = false,
							includeInlayParameterNameHints = "all",
							-- includeInlayParameterNameHintsWhenArgumentMatchesName = false,
							-- includeInlayPropertyDeclarationTypeHints = true,
							-- includeInlayVariableTypeHints = false,
							-- includeInlayVariableTypeHintsWhenTypeMatchesName = false,
						},
						-- prevent omni completion from inserting extra period
						completionDisableFilterText = true,
					},
					on_attach = function(client)
						client.server_capabilities.documentFormattingProvider = false
					end,
				})
			end,
			yamlls = function()
				lspconfig["yamlls"].setup({
					capabilities = capabilities,
					settings = {
						yaml = {
							keyOrdering = false,
						},
					},
				})
			end,
		})

		-- Non-Mason language servers
		lspconfig["denols"].setup({
			capabilities = capabilities,
			root_dir = function(file)
				return vim.fs.root(file, { "deno.json", "deno.jsonc" })
			end,
		})
		lspconfig["hls"].setup({
			capabilities = capabilities,
			on_attach = function(client)
				client.server_capabilities.documentFormattingProvider = false
			end,
		})
		lspconfig["rust_analyzer"].setup({
			capabilities = capabilities,
			settings = {
				["rust-analyzer"] = {
					cargo = { targetDir = true },
					check = {
						command = "clippy",
						extraArgs = {
							"--",
							"--warn=clippy::todo",
						},
					},
					inlayHints = {
						-- bindingModeHints = { enable = false },
						-- chainingHints = { enable = true },
						-- closingBraceHints = {
						-- 	enable = true,
						-- 	minLines = 25,
						-- },
						-- closureCaptureHints = { enable = false },
						closureReturnTypeHints = { enable = "always" },
						-- closureStyle = "impl_fn",
						-- discriminantHints = { enable = "never" },
						-- expressionAdjustmentHints = {
						-- 	enable = "never",
						-- 	hideOutsideUnsafe = false,
						-- 	mode = "prefix",
						-- },
						-- implicitDrops = { enable = false },
						lifetimeElisionHints = {
							enable = "always",
							useParameterNames = false,
						},
						-- maxLength = 25,
						-- parameterHints = { enable = true },
						-- rangeExclusiveHints = { enable = false },
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
		lspconfig["sourcekit"].setup({
			capabilities = capabilities,
			root_dir = function(file)
				return vim.fs.root(file, {
					"Package.swift",
					"*.xcodeproj",
				})
			end,
		})
	end,
}
