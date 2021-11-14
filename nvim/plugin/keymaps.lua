local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
map('i', '<c-space>', '<c-x><c-o>', opts)
map('n', '<s-tab>', '<c-o>', opts)
map('n', 'j', 'gj', opts)
map('n', 'k', 'gk', opts)
