local map = vim.api.nvim_set_keymap
map('n', '<leader>ff', '<cmd>lua require(\'telescope.builtin\').find_files()<cr>', {noremap = true, silent = true})
map('n', '<leader>fg', '<cmd>lua require(\'telescope.builtin\').live_grep()<cr>', {noremap = true, silent = true})
map('n', '<leader>fb', '<cmd>lua require(\'telescope.builtin\').buffers()<cr>', {noremap = true, silent = true})
map('n', '<leader>fh', '<cmd>lua require(\'telescope.builtin\').help_tags()<cr>', {noremap = true, silent = true})
map('n', '<leader>fd', '<cmd>lua require(\'telescope.builtin\').lsp_document_diagnostics()<cr>', {noremap = true, silent = true})

require('telescope').setup {
	defaults = {
		initial_mode = 'normal',
	}
}

require('telescope').load_extension('fzf')
