return {
	"nvim-telescope/telescope.nvim",
	requires = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			run = "make",
		},
	},
	config = function()
		local loaded, telescope = pcall(require, "telescope")
		if not loaded then return end

		local builtin = require("telescope.builtin")
		vim.api.nvim_create_user_command("Bcommits", builtin.git_bcommits, {})
		vim.api.nvim_create_user_command("Commits", builtin.git_commits, {})
		vim.api.nvim_create_user_command("Grep", builtin.live_grep, {})
		vim.api.nvim_create_user_command("Help", builtin.help_tags, {})
		vim.api.nvim_create_user_command("Status", builtin.git_status, {})
		vim.api.nvim_create_user_command("Tele", builtin.resume, {})
		vim.api.nvim_create_user_command(
			"Buffers",
			function() builtin.buffers({ sort_lastused = true }) end,
			{}
		)
		vim.api.nvim_create_user_command("Find", function()
			if vim.fn.system("git rev-parse --is-inside-work-tree"):match("true") then
				builtin.git_files({
					use_git_root = false,
					show_untracked = true,
				})
			else
				builtin.find_files({ hidden = true })
			end
		end, {})
		-- LSP lists
		vim.api.nvim_create_user_command("Defs", builtin.lsp_definitions, {})
		vim.api.nvim_create_user_command("Imps", builtin.lsp_implementations, {})
		vim.api.nvim_create_user_command("Refs", builtin.lsp_references, {})
		vim.api.nvim_create_user_command("Diags", function(t)
			if t.args == "all" then
				builtin.diagnostics({ bufnr = nil })
			else
				builtin.diagnostics({ bufnr = 0 })
			end
		end, { nargs = "?" })

		local actions = require("telescope.actions")
		local action_state = require("telescope.actions.state")

		local interactive_rebase = function(prompt_bufnr)
			local commit = action_state.get_selected_entry().value
			actions.close(prompt_bufnr)
			vim.api.nvim_command("tabnew | terminal git rebase --interactive " .. commit)
			vim.api.nvim_command("norm a")
		end

		local copy_commit = function(prompt_bufnr)
			local commit = action_state.get_selected_entry().value
			actions.close(prompt_bufnr)
			vim.fn.setreg("+", commit)
			vim.fn.timer_start(
				500,
				function() vim.notify(("Commit %s copied to clipboard!"):format(commit)) end
			)
		end

		telescope.setup({
			pickers = {
				git_bcommits = {
					mappings = {
						i = {
							["<c-r>r"] = interactive_rebase,
							["<c-r>y"] = copy_commit,
						},
					},
				},
				git_commits = {
					mappings = {
						i = {
							["<c-r>r"] = interactive_rebase,
							["<c-r>y"] = copy_commit,
						},
					},
				},
			},
		})
		require("telescope").load_extension("fzf")
	end,
}
