local map = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}

map('n', '<leader>ff', '<cmd>Telescope find_files<cr>', opts)
map('n', '<leader>ft', '<cmd>Telescope git_files<cr>', opts)
map('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', opts)
map('n', '<leader>fb', '<cmd>Telescope buffers<cr>', opts)
map('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', opts)

vim.cmd([[
	command! Browser Telescope file_browser
	command! Find Telescope find_files
	command! Tracked Telescope git_files
	command! Grep Telescope live_grep
	command! Buffers Telescope buffers
	command! Help Telescope help_tags
]])

local telescope = require('telescope')
telescope.setup {
	defaults = {
		prompt_prefix = '',
	},
	extensions = {
		fzf = {},
	}
}
telescope.load_extension('fzf')

