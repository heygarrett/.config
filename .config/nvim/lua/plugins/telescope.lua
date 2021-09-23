local map = vim.api.nvim_set_keymap
map('n', '<leader>ff', '<cmd>Telescope find_files<cr>', {noremap = true, silent = true})
map('n', '<leader>ft', '<cmd>Telescope git_files<cr>', {noremap = true, silent = true})
map('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', {noremap = true, silent = true})
map('n', '<leader>fb', '<cmd>Telescope buffers<cr>', {noremap = true, silent = true})
map('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', {noremap = true, silent = true})

local telescope = require('telescope')
telescope.load_extension('fzf')
telescope.setup {
	defaults = {}
}

