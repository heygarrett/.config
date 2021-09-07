require('plugins/packer')
require('plugins/lualine')
require('plugins/coq')
require('plugins/lsp')
require('plugins/nvim-lint')
require('plugins/indent-blankline')
vim.cmd('source $HOME/.config/nvim/viml/autocmds.vim')

vim.g.python3_host_prog = vim.env.HOME .. "/.local/venvs/nvim/bin/python"
vim.api.nvim_set_keymap('n', 'j', 'gj', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'k', 'gk', { noremap = true, silent = true })
vim.o.hidden = true -- soon to be default (merged into master)
vim.g.netrw_liststyle = 3
vim.o.cmdheight = 2
vim.o.scrolloff = 3
vim.o.number = true
vim.o.cursorline = true
vim.o.showmatch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.linebreak = true
vim.o.list = true
vim.o.confirm = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.foldenable = false
vim.o.foldmethod = 'indent'
vim.o.clipboard = 'unnamedplus'
vim.o.mouse = 'a'
