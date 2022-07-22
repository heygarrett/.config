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
		local telescope = require("telescope.builtin")
		vim.api.nvim_create_user_command("Bufs", telescope.buffers, {})
		vim.api.nvim_create_user_command("Commits", telescope.git_commits, {})
		vim.api.nvim_create_user_command("Grep", telescope.live_grep, {})
		vim.api.nvim_create_user_command("Help", telescope.help_tags, {})
		vim.api.nvim_create_user_command("Find", function()
			if vim.fn.system("git rev-parse --is-inside-work-tree"):match("true") then
				telescope.git_files({ use_git_root = false, show_untracked = true })
			else
				telescope.find_files({ hidden = true })
			end
		end, {})
		-- LSP lists
		vim.api.nvim_create_user_command("Defs", telescope.lsp_definitions, {})
		vim.api.nvim_create_user_command("Imps", telescope.lsp_implementations, {})
		vim.api.nvim_create_user_command("Refs", telescope.lsp_references, {})
		vim.api.nvim_create_user_command("Diags", function(t)
			if t.args == "all" then
				telescope.diagnostics({ bufnr = nil })
			else
				telescope.diagnostics({ bufnr = 0 })
			end
		end, { nargs = "?" })

		require("telescope").setup({
			defaults = {
				layout_config = { prompt_position = "top" },
				sorting_strategy = "ascending",
			},
		})
		require("telescope").load_extension("fzf")
	end,
}
