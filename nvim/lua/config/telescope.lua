return {
	"nvim-telescope/telescope.nvim",
	requires = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-file-browser.nvim",
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
		vim.api.nvim_create_user_command(
			"Defs",
			function() builtin.lsp_definitions({ jump_type = "never" }) end,
			{}
		)
		vim.api.nvim_create_user_command(
			"Imps",
			function() builtin.lsp_implementations({ jump_type = "never" }) end,
			{}
		)
		vim.api.nvim_create_user_command(
			"Refs",
			function() builtin.lsp_references({ jump_type = "never" }) end,
			{}
		)
		vim.api.nvim_create_user_command("Diags", function(t)
			if t.args == "all" then
				builtin.diagnostics({ bufnr = nil })
			else
				builtin.diagnostics({ bufnr = 0 })
			end
		end, { nargs = "?" })

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
			vim.defer_fn(
				function() vim.notify(("Commit %s copied to clipboard!"):format(commit)) end,
				500
			)
		end

		telescope.setup({
			defaults = {
				sorting_strategy = "ascending",
				layout_config = {
					prompt_position = "top",
				},
			},
			pickers = {
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

		telescope.load_extension("file_browser")
		vim.api.nvim_create_user_command(
			"Dir",
			function()
				telescope.extensions.file_browser.file_browser({
					path = "%:p:h",
					grouped = true,
					hidden = true,
					dir_icon = "",
				})
			end,
			{}
		)

		vim.api.nvim_create_autocmd("User", {
			group = vim.api.nvim_create_augroup("telescope", { clear = true }),
			pattern = "TelescopePreviewerLoaded",
			callback = function() vim.o.wrap = true end,
		})
	end,
}
