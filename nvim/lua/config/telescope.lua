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
		vim.cmd [[
			command! Browse Telescope file_browser
			command! Bufs Telescope buffers
			command! Find Telescope find_files
			command! Tracked Telescope git_files
			command! Grep Telescope live_grep
			command! Help Telescope help_tags
			" LSP lists
			command! Acts Telescope lsp_code_actions
			command! Defs Telescope lsp_definitions
			command! Doc Telescope lsp_document_diagnostics
			command! Imps Telescope lsp_implementations
			command! Refs Telescope lsp_references
		]]

		require('telescope').setup()
		require('telescope').load_extension('fzf')
	end
}
