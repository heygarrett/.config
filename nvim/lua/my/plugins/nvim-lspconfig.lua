return {
	"https://github.com/neovim/nvim-lspconfig",
	lazy = false,
	config = function()
		local lspconfig = require("lspconfig")

		require("mason-lspconfig").setup_handlers({
			-- Mason language servers with default setups
			function(server_name)
				lspconfig[server_name].setup({})
			end,

			-- Mason language servers with custom setups
			basedpyright = function()
				lspconfig["basedpyright"].setup({
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
			eslint = function()
				lspconfig["eslint"].setup({
					settings = { format = false },
				})
			end,
			gopls = function()
				lspconfig["gopls"].setup({
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
					settings = {
						Lua = {
							hint = {
								enable = true,
								---@type "Auto" | "Enable" | "Disable"
								arrayIndex = "Disable",
								-- await = true,
								-- awaitPropagate = false,
								---@type "All" | "Literal" | "Disable"
								paramName = "Literal",
								-- paramType = true,
								-- ---@type "All" | "SameLine" | "Disable"
								-- semicolon = "SameLine",
								setType = true,
							},
						},
					},
					---@param client vim.lsp.Client
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
							---@diagnostic disable-next-line: param-type-mismatch
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
						-- HACK: https://github.com/LuaLS/lua-language-server/issues/1809
						vim.api.nvim_set_hl(0, "@lsp.type.comment", {})
					end,
				})
			end,
			ruff = function()
				lspconfig["ruff"].setup({
					---@param client vim.lsp.Client
					on_attach = function(client)
						client.server_capabilities.hoverProvider = false
					end,
				})
			end,
			taplo = function()
				lspconfig["taplo"].setup({
					-- HACK: https://github.com/tamasfe/taplo/issues/580#issuecomment-2361679688
					root_dir = function()
						return vim.uv.cwd()
					end,
					---@param client vim.lsp.Client
					on_attach = function(client, bufnr)
						if not vim.fs.root(bufnr, { "taplo.toml", ".taplo.toml" }) then
							client.server_capabilities.documentFormattingProvider = false
						end
					end,
				})
			end,
			ts_ls = function()
				lspconfig["ts_ls"].setup({
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
					---@param client vim.lsp.Client
					on_attach = function(client)
						client.server_capabilities.documentFormattingProvider = false
					end,
				})
			end,
			yamlls = function()
				lspconfig["yamlls"].setup({
					settings = {
						yaml = { keyOrdering = false },
					},
				})
			end,
		})

		-- Non-Mason language servers
		lspconfig["denols"].setup({
			root_dir = function(file)
				return vim.fs.root(file, { "deno.json", "deno.jsonc" })
			end,
		})
		lspconfig["hls"].setup({
			---@param client vim.lsp.Client
			on_attach = function(client)
				client.server_capabilities.documentFormattingProvider = false
			end,
		})
		lspconfig["rust_analyzer"].setup({
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
			root_dir = function(file)
				return vim.fs.root(file, {
					"Package.swift",
					"*.xcodeproj",
				})
			end,
		})
	end,
}
