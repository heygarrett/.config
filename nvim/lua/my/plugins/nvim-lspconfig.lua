return {
	"https://github.com/neovim/nvim-lspconfig",
	lazy = false,
	branch = "master",
	config = function()
		local lspconfig = require("lspconfig")

		require("mason-lspconfig").setup_handlers({
			-- Mason language servers with default setups
			function(server_name)
				vim.lsp.enable(server_name)
			end,

			-- Mason language servers with custom setups
			basedpyright = function()
				vim.lsp.config("basedpyright", {
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
				vim.lsp.enable("basedpyright")
			end,
			biome = function()
				lspconfig["biome"].setup({
					---@param config vim.lsp.Config
					on_new_config = function(config)
						if vim.fn.executable("node_modules/.bin/biome") == 1 then
							config.cmd = { "node_modules/.bin/biome", "lsp-proxy" }
						end
					end,
					root_dir = function(file)
						local biome_root = vim.fs.root(file, {
							"biome.json",
							"biome.jsonc",
						})
						if biome_root then
							local node_root = vim.fs.root(file, {
								"package.json",
								"node_modules",
							})
							return node_root or biome_root
						else
							return nil
						end
					end,
				})
			end,
			eslint = function()
				vim.lsp.config("eslint", {
					settings = { format = false },
				})
				vim.lsp.enable("eslint")
			end,
			gopls = function()
				vim.lsp.config("gopls", {
					settings = {
						gopls = {
							hints = {
								assignVariableTypes = true,
								compositeLiteralFields = true,
								-- compositeLiteralTypes = true,
								constantValues = true,
								functionTypeParameters = true,
								parameterNames = true,
								rangeVariableTypes = true,
							},
						},
					},
				})
				vim.lsp.enable("gopls")
			end,
			lua_ls = function()
				vim.lsp.config("lua_ls", {
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
				vim.lsp.enable("lua_ls")
			end,
			ruff = function()
				vim.lsp.config("ruff", {
					---@param client vim.lsp.Client
					on_attach = function(client)
						client.server_capabilities.hoverProvider = false
					end,
				})
				vim.lsp.enable("ruff")
			end,
			taplo = function()
				vim.lsp.config("taplo", {
					-- HACK: https://github.com/tamasfe/taplo/issues/580#issuecomment-2361679688
					---@param _ integer
					---@param callback fun(root_dir?: string)
					root_dir = function(_, callback)
						callback(vim.uv.cwd())
					end,
					---@param client vim.lsp.Client
					on_attach = function(client, bufnr)
						if
							not vim.fs.root(bufnr, {
								"taplo.toml",
								".taplo.toml",
							})
						then
							client.server_capabilities.documentFormattingProvider = false
						end
					end,
				})
				vim.lsp.enable("taplo")
			end,
			ts_ls = function()
				vim.lsp.config("ts_ls", {
					---@param bufnr integer
					---@param callback fun(root_dir?: string)
					root_dir = function(bufnr, callback)
						local config_root = vim.fs.root(bufnr, {
							"jsconfig.json",
							"tsconfig.json",
						})
						if config_root then
							callback(config_root)
						end
					end,
					workspace_required = true,
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
				vim.lsp.enable("ts_ls")
			end,
			yamlls = function()
				vim.lsp.config("yamlls", {
					settings = {
						yaml = {
							keyOrdering = false,
						},
					},
				})
				vim.lsp.enable("yamlls")
			end,
		})

		-- Non-Mason language servers
		vim.lsp.config("denols", {
			---@param bufnr integer
			---@param callback fun(root_dir?: string)
			root_dir = function(bufnr, callback)
				if not vim.fs.root(bufnr, { "jsconfig.json", "tsconfig.json" }) then
					callback(vim.fs.root(bufnr, {
						"deno.json",
						"deno.jsonc",
					}) or vim.uv.cwd())
				end
			end,
			---@param client vim.lsp.Client
			---@param bufnr integer
			on_attach = function(client, bufnr)
				if not vim.fs.root(bufnr, { "deno.json", "deno.jsonc" }) then
					client.config.settings.deno =
						---@diagnostic disable-next-line: param-type-mismatch
						vim.tbl_deep_extend("force", client.config.settings.deno, {

							config = vim.fs.joinpath(
								vim.env.XDG_CONFIG_HOME,
								"deno/deno.json"
							),
						})
				end
			end,
		})
		vim.lsp.enable("denols")

		vim.lsp.config("hls", {
			---@param client vim.lsp.Client
			on_attach = function(client)
				client.server_capabilities.documentFormattingProvider = false
			end,
		})
		vim.lsp.enable("hls")

		vim.lsp.config("rust_analyzer", {
			settings = {
				["rust-analyzer"] = {
					cargo = {
						targetDir = true,
					},
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
		vim.lsp.enable("rust_analyzer")

		vim.lsp.config("sourcekit", {
			---@param bufnr integer
			---@param callback fun(root_dir?: string)
			root_dir = function(bufnr, callback)
				callback(vim.fs.root(bufnr, function(name)
					return vim.tbl_contains({
						"Package.swift",
						"%.xcodeproj$",
					}, function(marker)
						return name:match(marker) ~= nil
					end, { predicate = true })
				end))
			end,
		})
		vim.lsp.enable("sourcekit")
	end,
}
