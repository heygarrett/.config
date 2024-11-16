local conform = function()
	return require("conform")
end

local formatters_by_filetype = {
	c = { "astyle" },
	fish = { "fish_indent" },
	go = {
		"golines",
		"goimports",
		stop_after_first = true,
	},
	haskell = { "fourmolu" },
	lua = { "stylua" },
	python = {
		"black",
		"yapf",
		stop_after_first = true,
	},
	swift = {
		"swift_format",
		"swiftformat",
		stop_after_first = true,
	},
	yaml = {
		"prettierd",
		"yamlfmt",
		stop_after_first = true,
	},
}

local format_with_prettierd = {
	"css",
	"html",
	"javascript",
	"javascriptreact",
	"json",
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
	lazy = true,
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

			local formatted = conform().format({ range = format_range })
			if formatted and vim.bo.filetype ~= "markdown" then
				vim.cmd.Retab({
					bang = not command_opts.bang,
					range = retab_range,
				})
			end
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
		default_format_opts = { lsp_format = "fallback" },
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
				env = { PRETTIERD_LOCAL_PRETTIER_ONLY = 1 },
				condition = function()
					if next(vim.lsp.get_clients({ name = "biome" })) then
						return false
					end

					local prettierd_info_cmd = vim.system({
						"prettierd",
						"--debug-info",
						".",
					}, {
						env = { PRETTIERD_LOCAL_PRETTIER_ONLY = "1" },
					}):wait()

					return prettierd_info_cmd.stdout:find("Loaded") ~= nil
				end,
			},
			swift_format = {
				cwd = function()
					return vim.fs.root(".swift-format", { upward = true })
				end,
				require_cwd = true,
			},
			swiftformat = {
				cwd = function()
					return vim.fs.root(".swiftformat", { upward = true })
				end,
				require_cwd = true,
			},
		},
	},
}
