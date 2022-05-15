return {
	'nvim-telescope/telescope.nvim',
	requires = {
		'nvim-lua/plenary.nvim',
		{
			'nvim-telescope/telescope-fzf-native.nvim',
			run = 'make',
		},
	},
	config = function()
		vim.api.nvim_create_user_command('Bufs', 'Telescope buffers', {})
		vim.api.nvim_create_user_command('Find', 'Telescope find_files', {})
		vim.api.nvim_create_user_command('Tracked', 'Telescope git_files', {})
		vim.api.nvim_create_user_command('Grep', 'Telescope live_grep', {})
		vim.api.nvim_create_user_command('Help', 'Telescope help_tags', {})
		-- LSP lists
		vim.api.nvim_create_user_command('Acts', 'Telescope lsp_code_actions', {})
		vim.api.nvim_create_user_command('Defs', 'Telescope lsp_definitions', {})
		vim.api.nvim_create_user_command('Diags', 'Telescope diagnostics bufnr=0', {})
		vim.api.nvim_create_user_command('Imps', 'Telescope lsp_implementations', {})
		vim.api.nvim_create_user_command('Refs', 'Telescope lsp_references', {})

		require('telescope').setup({})
		require('telescope').load_extension('fzf')
	end
}
