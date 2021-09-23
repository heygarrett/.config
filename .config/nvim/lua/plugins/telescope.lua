local map = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}

map('n', '<leader>ff', '<cmd>Telescope find_files<cr>', opts)
map('n', '<leader>ft', '<cmd>Telescope git_files<cr>', opts)
map('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', opts)
map('n', '<leader>fb', '<cmd>Telescope buffers<cr>', opts)
map('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', opts)

local telescope = require('telescope')
telescope.load_extension('fzf')
telescope.setup {
	defaults = {}
}

