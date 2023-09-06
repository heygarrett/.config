local helpers = require("my.helpers")

return {
	"https://github.com/ibhagwan/fzf-lua",
	config = function()
		local fzf_lua = require("fzf-lua")

		vim.api.nvim_create_user_command(
			"Autocommands",
			fzf_lua.autocmds,
			{ desc = "fzf-lua picker: autocommands" }
		)
		vim.api.nvim_create_user_command("BCommits", function(t)
			if t.args == "" then
				fzf_lua.git_bcommits()
			else
				fzf_lua.git_bcommits({
					cmd = table.concat({
						"git",
						"log",
						t.args .. "..HEAD",
						"--oneline",
					}, " "),
				})
			end
		end, {
			nargs = "?",
			complete = helpers.get_branches,
			desc = "fzf-lua picker: buffer commits",
		})
		vim.api.nvim_create_user_command(
			"Buffers",
			fzf_lua.buffers,
			{ desc = "fzf-lua picker: buffers" }
		)
		vim.api.nvim_create_user_command(
			"Commands",
			fzf_lua.commands,
			{ desc = "fzf-lua picker: user commands" }
		)
		vim.api.nvim_create_user_command("Commits", function(t)
			if t.args == "" then
				fzf_lua.git_commits()
			else
				fzf_lua.git_commits({
					cmd = table.concat({
						"git",
						"log",
						t.args .. "..HEAD",
						"--oneline",
					}, " "),
				})
			end
		end, {
			nargs = "?",
			complete = helpers.get_branches,
			desc = "fzf-lua picker: commits",
		})
		vim.api.nvim_create_user_command("Find", function()
			vim.fn.system({ "git", "rev-parse", "--is-inside-work-tree" })
			if vim.v.shell_error == 0 then
				fzf_lua.git_files({ cwd = vim.loop.cwd() })
			else
				fzf_lua.files()
			end
		end, { desc = "fzf-lua picker: find files" })
		vim.api.nvim_create_user_command(
			"Grep",
			fzf_lua.live_grep_native,
			{ desc = "fzf-lua picker: grep" }
		)
		vim.api.nvim_create_user_command("Help", fzf_lua.help_tags, {
			desc = "fzf-lua picker: help tags",
		})
		vim.api.nvim_create_user_command(
			"Keymaps",
			fzf_lua.keymaps,
			{ desc = "fzf-lua picker: keymaps" }
		)
		vim.api.nvim_create_user_command(
			"Picker",
			fzf_lua.resume,
			{ desc = "fzf-lua picker: re-open last picker" }
		)
		vim.api.nvim_create_user_command(
			"Status",
			fzf_lua.git_status,
			{ desc = "fzf-lua picker: git status" }
		)

		-- LSP
		vim.api.nvim_create_user_command(
			"Actions",
			fzf_lua.lsp_code_actions,
			{ desc = "fzf-lua picker: code actions" }
		)
		vim.api.nvim_create_user_command(
			"Definitions",
			fzf_lua.lsp_definitions,
			{ desc = "fzf-lua picker: LSP definitions" }
		)
		vim.api.nvim_create_user_command("Diagnostics", function()
			local success, choice = pcall(vim.fn.confirm, "", "&Document\n&workspace")
			if not success then
				return
			elseif choice == 2 then
				fzf_lua.diagnostics_workspace()
			else
				fzf_lua.diagnostics_document()
			end
		end, {
			nargs = "?",
			desc = "fzf-lua picker: diagnostics",
		})
		vim.api.nvim_create_user_command(
			"Implementations",
			fzf_lua.lsp_implementations,
			{ desc = "fzf-lua picker: LSP implementations" }
		)
		vim.api.nvim_create_user_command(
			"References",
			fzf_lua.lsp_references,
			{ desc = "fzf-lua picker: LSP references" }
		)
		vim.api.nvim_create_user_command("Symbols", function()
			local success, choice = pcall(vim.fn.confirm, "", "&Document\n&workspace")
			if not success then
				return
			elseif choice == 2 then
				fzf_lua.lsp_workspace_symbols()
			else
				fzf_lua.lsp_document_symbols()
			end
		end, { desc = "fzf-lua picker: LSP symbols" })

		local actions = require("fzf-lua.actions")
		local copy_hash = function(selected)
			local commit = selected[1]:match("[^ ]+")
			vim.fn.setreg("+", commit)
			---@diagnostic disable: param-type-mismatch
			vim.defer_fn(
				function() vim.notify(commit .. " copied to clipboard!") end,
				500
			)
		end

		fzf_lua.setup({
			winopts = {
				preview = {
					layout = "vertical",
					vertical = "down:75%",
				},
			},
			keymap = {
				builtin = {
					["<c-d>"] = "preview-page-down",
					["<c-u>"] = "preview-page-up",
				},
				fzf = {
					["ctrl-d"] = "preview-half-page-down",
					["ctrl-u"] = "preview-half-page-up",
				},
			},
			actions = {
				buffers = {
					["default"] = actions.buf_edit_or_qf,
					["ctrl-t"] = actions.buf_tabedit,
					["ctrl-v"] = actions.buf_vsplit,
					["ctrl-x"] = actions.buf_split,
				},
				files = {
					["default"] = actions.file_edit_or_qf,
					["ctrl-t"] = actions.file_tabedit,
					["ctrl-v"] = actions.file_vsplit,
					["ctrl-x"] = actions.file_split,
				},
			},
			helptags = {
				actions = {
					["default"] = actions.help_vert,
					["ctrl-x"] = actions.help,
				},
			},
			git = {
				status = {
					cmd = "git status --short --untracked-files",
					actions = {
						["right"] = false,
						["left"] = false,
						["ctrl-x"] = false,
						["ctrl-r"] = { fn = actions.git_reset, reload = true },
						["tab"] = { fn = actions.git_stage_unstage, reload = true },
					},
				},
				commits = {
					cmd = "git log --color --pretty=format:" .. table.concat({
						"'%C(yellow)%h%Creset",
						"%Cgreen(%><(12)%cr%><|(12))%Creset",
						"%s",
						"%C(blue)<%ae>%Creset'",
					}, " "),
					actions = {
						["default"] = copy_hash,
						["ctrl-y"] = false,
					},
				},
				bcommits = {
					cmd = "git log --color --pretty=format:" .. table.concat({
						"'%C(yellow)%h%Creset",
						"%Cgreen(%><(12)%cr%><|(12))%Creset",
						"%s",
						"%C(blue)<%ae>%Creset'",
						"<file>",
					}, " "),
					actions = {
						["default"] = copy_hash,
						["ctrl-y"] = false,
					},
				},
			},
		})
	end,
}
