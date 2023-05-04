local builtins = function() return require("telescope.builtin") end

return {
	"https://github.com/nvim-telescope/telescope.nvim",
	lazy = true,
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
		vim.api.nvim_create_user_command(
			"Bcommits",
			function() builtins().git_bcommits() end,
			{ desc = "Telescope picker: buffer commits" }
		)
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
		vim.api.nvim_create_user_command(
			"Commits",
			function() builtins().git_commits() end,
			{ desc = "Telescope picker: commits" }
		)
		vim.api.nvim_create_user_command("Find", function()
			if vim.fn.system("git rev-parse --is-inside-work-tree"):match("true") then
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
			"Status",
			function() builtins().git_status() end,
			{ desc = "Telescope picker: git status" }
		)
		vim.api.nvim_create_user_command(
			"Tele",
			function() builtins().resume() end,
			{ desc = "Telescope picker: resume" }
		)
		-- LSP lists
		vim.api.nvim_create_user_command(
			"Defs",
			function() builtins().lsp_definitions({ jump_type = "never" }) end,
			{ desc = "Telescope picker: LSP definitions" }
		)
		vim.api.nvim_create_user_command("Diags", function(t)
			if t.args == "all" then
				builtins().diagnostics({ bufnr = nil })
			else
				builtins().diagnostics({ bufnr = 0 })
			end
		end, {
			nargs = "?",
			desc = "Telescope picker: diagnostics",
		})
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
	end,
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local action_state = require("telescope.actions.state")
		local function new_tab_with_command(cmd, commit)
			vim.cmd.tabnew()
			vim.cmd.terminal()
			local term_channel = vim.bo.channel
			vim.api.nvim_chan_send(
				term_channel,
				table.concat({ cmd, commit }, " ") .. "\r"
			)
			vim.cmd.normal({
				args = { "a" },
			})
		end

		local interactive_rebase = function(prompt_bufnr)
			local commit = action_state.get_selected_entry().value
			actions.close(prompt_bufnr)
			new_tab_with_command("git rebase --interactive", commit)
		end

		local commit_info = function(prompt_bufnr)
			local commit = action_state.get_selected_entry().value
			actions.close(prompt_bufnr)
			new_tab_with_command("git show", commit)
		end

		local copy_commit = function(prompt_bufnr)
			local commit = action_state.get_selected_entry().value
			actions.close(prompt_bufnr)
			vim.fn.setreg("+", commit)
			---@diagnostic disable: param-type-mismatch
			vim.defer_fn(
				function() vim.notify(("Commit %s copied to clipboard!"):format(commit)) end,
				500
			)
		end

		telescope.setup({
			defaults = {
				wrap_results = true,
				sorting_strategy = "ascending",
				layout_config = {
					prompt_position = "top",
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
				git_bcommits = {
					mappings = {
						i = {
							["<c-r>r"] = interactive_rebase,
							["<c-r>s"] = commit_info,
							["<c-r>y"] = copy_commit,
						},
					},
				},
				git_commits = {
					mappings = {
						i = {
							["<c-r>r"] = interactive_rebase,
							["<c-r>s"] = commit_info,
							["<c-r>y"] = copy_commit,
						},
					},
				},
			},
		})
		telescope.load_extension("fzf")

		vim.api.nvim_create_autocmd("User", {
			desc = "wrap text in Telescope pickers",
			group = vim.api.nvim_create_augroup("telescope", { clear = true }),
			pattern = "TelescopePreviewerLoaded",
			callback = function() vim.o.wrap = true end,
		})
	end,
}
