local formatters_by_filetype = {
	c = { "astyle" },
	haskell = { "fourmolu" },
	python = {
		"black",
		"yapf",
	},
	swift = {
		"swiftformat",
		"swift_format",
	},
	yaml = {
		"prettierd",
		"yamlfmt",
	},
}

local format_with_prettierd = {
	"css",
	"html",
	"javascript",
	"javascriptreact",
	"json",
	"json5",
	"jsonc",
	"markdown",
	"scss",
	"typescript",
	"typescript.tsx",
	"typescriptreact",
}

for _, ft in ipairs(format_with_prettierd) do
	formatters_by_filetype[ft] = { "prettierd" }
end

return {
	"https://github.com/stevearc/conform.nvim",
	cmd = { "ConformInfo" },
	init = function()
		vim.api.nvim_create_user_command("Format", function(command_opts)
			local format_range
			local retab_range
			if command_opts.range == 2 then
				format_range = {
					start = { command_opts.line1, 0 },
					["end"] = { command_opts.line2, 0 },
				}
				retab_range = { command_opts.line1, command_opts.line2 }
			end

			require("conform").format(
				{ range = format_range },
				---@param err string?
				function(err)
					if vim.bo.filetype == "markdown" then
						-- don't auto-retab Markdown because it may
						-- use a mix of tabs and spaces (code snippets)
						return
					end
					if err then
						vim.notify_once(err)
						return
					end

					if not command_opts.bang then
						-- HACK: if the :Retab! command is not delayed by at least ~250 ms
						-- its prompt gets covered by the status line (not sure why)
						vim.wait(250)
					end
					vim.cmd.Retab({
						bang = not command_opts.bang,
						range = retab_range,
					})
				end
			)
		end, {
			bang = true,
			range = "%",
			desc = "synchronous formatting",
		})

		local group = vim.api.nvim_create_augroup("conform", { clear = true })
		vim.api.nvim_create_autocmd("BufWritePre", {
			desc = "format on save",
			group = group,
			callback = function()
				vim.cmd.Format({ bang = true })
			end,
		})
	end,
	opts = {
		default_format_opts = {
			lsp_format = "fallback",
			stop_after_first = true,
		},
		formatters_by_ft = formatters_by_filetype,
		formatters = {
			astyle = {
				prepend_args = {
					"--indent=force-tab",
					"--convert-tabs",
					"--style=attach",
					"--squeeze-ws",
				},
				condition = function()
					-- defer to clangd if .clang-format file is present
					return vim.tbl_isempty(
						vim.fs.find(".clang-format", { upward = true })
					)
				end,
			},
			fourmolu = {
				prepend_args = function(_, context)
					local args = {}
					if
						vim.tbl_isempty(vim.fs.find("fourmolu.yaml", {
							path = context.dirname,
							upward = true,
						}))
					then
						table.insert(args, "--indent-wheres=true")
					end
					return args
				end,
			},
			prettierd = {
				condition = function(_, ctx)
					local is_js_filetype = vim.regex("\\v^(javascript|typescript)")
						:match_str(vim.bo[ctx.buf].filetype)
					local vtsls_attached =
						next(vim.lsp.get_clients({ bufnr = ctx.buf, name = "vtsls" }))
					local biome_attached =
						next(vim.lsp.get_clients({ bufnr = ctx.buf, name = "biome" }))
					if is_js_filetype and not vtsls_attached then
						return false
					end
					if biome_attached then
						return false
					end

					local local_prettier_installed = vim.system({
						"prettierd",
						"--debug-info",
						".",
					}, {
						env = { PRETTIERD_LOCAL_PRETTIER_ONLY = 1 },
					})
						:wait().stdout
						:find("Loaded")
					if not local_prettier_installed then
						return false
					end

					return true
				end,
			},
			swift_format = {
				prepend_args = function(_, ctx)
					if not vim.fs.root(ctx.buf, ".swift-format") then
						return {
							"--configuration",
							vim.fs.joinpath(
								vim.env.XDG_CONFIG_HOME,
								"swift-format",
								"config.json"
							),
						}
					end
				end,
			},
			swiftformat = {
				cwd = function(_, ctx)
					return vim.fs.root(ctx.buf, ".swiftformat")
				end,
				require_cwd = true,
			},
		},
	},
}
