require('plugins/packer')
require('plugins/lspconfig')
require('plugins/efm-langserver')
require('plugins/lualine')
require('plugins/indexed-search')

vim.g.python3_host_prog = vim.env.HOME .. "/.local/venvs/nvim/bin/python"
vim.g.netrw_liststyle = 3
vim.opt.hidden = true -- soon to be default (merged into master)
vim.opt.path:append({'**'})
vim.opt.termguicolors = true
vim.opt.cmdheight = 2
vim.opt.scrolloff = 3
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.showmatch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.linebreak = true
vim.opt.list = true
vim.opt.confirm = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.foldenable = false
vim.opt.foldmethod = 'indent'
vim.opt.clipboard:append({'unnamedplus'})
vim.opt.mouse = 'a'
vim.opt.expandtab = false
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

local map = vim.api.nvim_set_keymap
map('n', 'j', 'gj', {noremap = true, silent = true})
map('n', 'k', 'gk', {noremap = true, silent = true})
map('n', '<s-tab>', '<c-o>', {noremap = true, silent = true})
map('n', '<leader>ff', '<cmd>lua require(\'telescope.builtin\').find_files()<cr>', {noremap = true, silent = true})
map('n', '<leader>fg', '<cmd>lua require(\'telescope.builtin\').live_grep()<cr>', {noremap = true, silent = true})
map('n', '<leader>fb', '<cmd>lua require(\'telescope.builtin\').buffers()<cr>', {noremap = true, silent = true})
map('n', '<leader>fh', '<cmd>lua require(\'telescope.builtin\').help_tags()<cr>', {noremap = true, silent = true})

vim.api.nvim_command('colorscheme dracula_pro')
vim.g.dracula_colorterm = 0

vim.cmd([[
	"" Set local indentation preferences *after* ftplugins
	"" but *before* plugin scripts (eg, sleuth, editorconfig)
	filetype plugin indent on
	autocmd FileType * setlocal expandtab< tabstop< softtabstop< shiftwidth<
]])
