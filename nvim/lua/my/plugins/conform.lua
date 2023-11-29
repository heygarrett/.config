local formatters_by_ft = {
	fish = { "fish_indent" },
	lua = { "stylua" },
	python = { { "black", "yapf" } },
	swift = { { "swift_format", "swiftformat" } },
}

local format_with_prettier = {
	"css",
	"html",
	"javascript",
	"javascriptreact",
	"json",
	"jsonc",
	"markdown",
	"scss",
	"typescript",
	"typescriptreact",
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
				prettierd = {
					env = { PRETTIERD_LOCAL_PRETTIER_ONLY = 1 },
					condition = function()
						local biome_config = vim.fs.find(
							"biome.json",
							{ upward = true, type = "file" }
						)[1]
						if biome_config then
							return false
						end

						local prettierd_info = vim.fn.system(
							"PRETTIERD_LOCAL_PRETTIER_ONLY=1 prettierd --debug-info ."
						)
						return prettierd_info:find("Loaded") and true or false
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
					prepend_args = { "--configuration", ".swift-format" },
				},
				swiftformat = {
					cwd = util.root_file({ ".swiftformat" }),
					require_cwd = true,
				},
			},
			format_on_save = function() vim.cmd.Format({ args = { "save" } }) end,
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
	end,
}
