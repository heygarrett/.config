local formatters_by_ft = {
	c = { "astyle" },
	fish = { "fish_indent" },
	go = { { "golines", "goimports" } },
	lua = { "stylua" },
	python = { { "black", "yapf" } },
	swift = { { "swift_format", "swiftformat" } },
	yaml = { { "prettierd", "yamlfmt" } },
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
	formatters_by_ft[ft] = { "prettierd" }
end

return {
	"https://github.com/stevearc/conform.nvim",
	lazy = true,
	event = "LspAttach",
	ft = vim.tbl_keys(formatters_by_ft),
	config = function()
		local conform = require("conform")
		local util = require("conform.util")

		conform.setup({
			formatters_by_ft = formatters_by_ft,
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
							env = { ["PRETTIERD_LOCAL_PRETTIER_ONLY"] = "1" },
						}):wait()
						return prettierd_info_cmd.stdout:find("Loaded") and true or false
					end,
				},
				swift_format = {
					cwd = util.root_file({ ".swift-format" }),
					require_cwd = true,
				},
				swiftformat = {
					cwd = util.root_file({ ".swiftformat" }),
					require_cwd = true,
				},
			},
		})

		vim.api.nvim_create_user_command("Format", function(command_opts)
			local formatted = conform.format({ lsp_format = "fallback" })
			if formatted then
				vim.cmd.Retab({ bang = not command_opts.bang })
			end
		end, {
			bang = true,
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
}
