local formatters_by_ft = {
	fish = { "fish_indent" },
	go = { "goimports" },
	lua = { "stylua" },
	python = { { "black", "yapf" } },
	swift = { { "swift_format", "swiftformat" } },
}

local format_with_biome = {
	"javascript",
	"javascriptreact",
	"json",
	"jsonc",
	"typescript",
	"typescript.tsx",
	"typescriptreact",
}

for _, ft in ipairs(format_with_biome) do
	formatters_by_ft[ft] = { { "biome", "prettierd" } }
end

local format_with_prettier = {
	"css",
	"html",
	"markdown",
	"scss",
	"yaml",
}

for _, ft in ipairs(format_with_prettier) do
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
				biome = {
					cwd = util.root_file("biome.json"),
					require_cwd = true,
				},
				prettierd = {
					env = { PRETTIERD_LOCAL_PRETTIER_ONLY = 1 },
					condition = function()
						local prettierd_info_cmd = vim.system({
							"prettierd",
							"--debug-info",
							".",
						}, {
							env = { ["PRETTIERD_LOCAL_PRETTIER_ONLY"] = "1" },
						}):wait()
						return prettierd_info_cmd.stdout:find("Loaded") and true
							or false
					end,
				},
				stylua = {
					cwd = util.root_file({
						".stylua.toml",
						"stylua.toml",
					}),
					require_cwd = true,
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

		local guess_indent_loaded, guess_indent = pcall(require, "guess-indent")
		vim.api.nvim_create_user_command("Format", function(args)
			-- Run formatter
			local formatted = conform.format({ lsp_fallback = true })
			if not formatted then
				return
			end

			-- Determine indentation after formatting
			if not guess_indent_loaded then
				return
			end
			local indent = guess_indent.guess_from_buffer()

			-- Match indentation to value of expandtab
			if (indent == "tabs") == vim.bo.expandtab then
				-- Prompt for retab if formatting manually
				if args.args ~= "save" then
					local success, choice = pcall(
						vim.fn.confirm,
						"Override formatter indentation?",
						"&Yes\n&no"
					)
					if not success then
						return
					elseif choice == 2 then
						return
					end
				end
				-- then retab
				local preferred_tabstop = (
					vim.bo.expandtab and vim.bo.tabstop or vim.go.tabstop
				)
				if indent ~= "tabs" then
					vim.bo.tabstop = tonumber(indent)
				end
				vim.cmd.retab({
					bang = true,
				})
				vim.bo.tabstop = preferred_tabstop
				if not vim.bo.expandtab then
					vim.bo.shiftwidth = 0
				end
			end
		end, {
			nargs = "?",
			desc = "synchronous formatting",
		})

		local group = vim.api.nvim_create_augroup("conform", { clear = true })
		vim.api.nvim_create_autocmd("BufWritePre", {
			desc = "format on save",
			group = group,
			callback = function() vim.cmd.Format({ args = { "save" } }) end,
		})
	end,
}
