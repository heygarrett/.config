local builtins = function() return require("telescope.builtin") end
local helpers = require("my.helpers")

return {
	"https://github.com/nvim-telescope/telescope.nvim",
	cond = false,
	dependencies = {
		"https://github.com/nvim-lua/plenary.nvim",
		{
			"https://github.com/nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
	},
	init = function()
		vim.api.nvim_create_user_command(
			"Autocommands",
			function() builtins().autocommands() end,
			{ desc = "Telescope picker: autocommands" }
		)
		vim.api.nvim_create_user_command("BCommits", function(t)
			if t.args == "" then
				builtins().git_bcommits()
			else
				builtins().git_bcommits({
					git_command = {
						"git",
						"log",
						t.args .. "..HEAD",
						"--oneline",
					},
				})
			end
		end, {
			nargs = "?",
			complete = helpers.get_branches,
			desc = "Telescope picker: buffer commits",
		})
		vim.api.nvim_create_user_command(
			"Buffers",
			function() builtins().buffers({ sort_lastused = true }) end,
			{ desc = "Telescope picker: buffers" }
		)
		vim.api.nvim_create_user_command(
			"Commands",
			function() builtins().commands() end,
			{ desc = "Telescope picker: user commands" }
		)
		vim.api.nvim_create_user_command("Commits", function(t)
			if t.args == "" then
				builtins().git_commits()
			else
				builtins().git_commits({
					git_command = {
						"git",
						"log",
						t.args .. "..HEAD",
						"--oneline",
					},
				})
			end
		end, {
			nargs = "?",
			complete = helpers.get_branches,
			desc = "Telescope picker: commits",
		})
		vim.api.nvim_create_user_command("Find", function()
			vim.fn.system({ "git", "rev-parse", "--is-inside-work-tree" })
			if vim.v.shell_error == 0 then
				builtins().git_files({ use_git_root = false, show_untracked = true })
			else
				builtins().find_files({ hidden = true })
			end
		end, { desc = "Telescope picker: find files" })
		vim.api.nvim_create_user_command(
			"Grep",
			function() builtins().live_grep() end,
			{ desc = "Telescope picker: grep" }
		)
		vim.api.nvim_create_user_command(
			"Help",
			function() builtins().help_tags() end,
			{ desc = "Telescope picker: help tags" }
		)
		vim.api.nvim_create_user_command(
			"Keymaps",
			function() builtins().keymaps() end,
			{ desc = "Telescope picker: keymaps" }
		)
		vim.api.nvim_create_user_command(
			"Picker",
			function() builtins().resume() end,
			{ desc = "Telescope picker: re-open last picker" }
		)
		vim.api.nvim_create_user_command(
			"Status",
			function() builtins().git_status() end,
			{ desc = "Telescope picker: git status" }
		)
		-- LSP lists
		vim.api.nvim_create_user_command(
			"Defs",
			function() builtins().lsp_definitions({ jump_type = "never" }) end,
			{ desc = "Telescope picker: LSP definitions" }
		)
		vim.api.nvim_create_user_command("Diags", function()
			local success, choice = pcall(vim.fn.confirm, "", "&Document\n&workspace")
			if not success then
				return
			elseif choice == 2 then
				builtins().diagnostics({ bufnr = nil })
			else
				builtins().diagnostics({ bufnr = 0 })
			end
		end, { desc = "Telescope picker: diagnostics" })
		vim.api.nvim_create_user_command(
			"Imps",
			function() builtins().lsp_implementations({ jump_type = "never" }) end,
			{ desc = "Telescope picker: LSP implementations" }
		)
		vim.api.nvim_create_user_command(
			"Refs",
			function() builtins().lsp_references({ jump_type = "never" }) end,
			{ desc = "Telescope picker: LSP references" }
		)
		vim.api.nvim_create_user_command("Symbols", function()
			local success, choice = pcall(vim.fn.confirm, "", "&Document\n&workspace")
			if not success then
				return
			elseif choice == 2 then
				builtins().lsp_dynamic_workspace_symbols()
			else
				builtins().lsp_document_symbols()
			end
		end, { desc = "Telescope picker: LSP symbols" })
	end,
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local action_state = require("telescope.actions.state")

		telescope.setup({
			defaults = {
				wrap_results = true,
				sorting_strategy = "ascending",
				layout_strategy = "vertical",
				layout_config = {
					vertical = {
						prompt_position = "top",
						mirror = true,
						preview_height = 0.75,
					},
				},
				dynamic_preview_title = true,
				mappings = {
					i = {
						["<c-s>"] = actions.cycle_previewers_next,
						["<c-a>"] = actions.cycle_previewers_prev,
					},
				},
			},
			pickers = {
				help_tags = {
					mappings = {
						i = {
							["<cr>"] = actions.select_vertical,
						},
					},
				},
			},
		})
		telescope.load_extension("fzf")

		local group = vim.api.nvim_create_augroup("telescope", { clear = true })

		vim.api.nvim_create_autocmd("User", {
			desc = "wrap text in Telescope pickers",
			group = group,
			pattern = "TelescopePreviewerLoaded",
			callback = function() vim.o.wrap = true end,
		})

		vim.api.nvim_create_autocmd("FileType", {
			desc = "Picker commands/keymaps",
			group = group,
			pattern = "TelescopePrompt",
			callback = function(tbl)
				local picker = action_state.get_current_picker(tbl.buf).prompt_title

				if picker:match("Commits") then
					if not picker:match("BCommits") then
						actions.cycle_previewers_next(tbl.buf)
						actions.cycle_previewers_next(tbl.buf)
					end
					vim.keymap.set("i", "<cr>", function()
						local commit = action_state.get_selected_entry().value
						actions.close(tbl.buf)
						vim.fn.setreg("+", commit)
						vim.defer_fn(
							function() vim.notify(commit .. " copied to clipboard!") end,
							500
						)
						vim.cmd.tabnew()
						vim.cmd.terminal()
						vim.api.nvim_chan_send(vim.bo.channel, "clear\r")
						vim.api.nvim_chan_send(
							vim.bo.channel,
							table.concat({ "git", "show", commit }, " ") .. "\r"
						)
						vim.api.nvim_feedkeys("a", "t", false)
					end, {
						buffer = tbl.buf,
						desc = "Yank commit hash and open new terminal",
					})
				elseif picker:match("Status") then
					vim.keymap.set("i", "<c-r>", function()
						vim.fn.system({
							"git",
							"restore",
							action_state.get_selected_entry().value,
						})
						builtins().git_status()
					end, {
						buffer = tbl.buf,
						desc = "Restore file",
					})
				end
			end,
		})
	end,
}
