require('plugins/efm-langserver')
require('plugins/indexed-search')
require('plugins/lspconfig')
require('plugins/lualine')
require('plugins/packer')
require('plugins/telescope')
require('plugins/treesitter')
require('utils/diagnostic-signs')

-- Colorscheme
vim.api.nvim_command('colorscheme dracula_pro')

-- Mappings
local map = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}
map('n', 'j', 'gj', opts)
map('n', 'k', 'gk', opts)
map('n', '<s-tab>', '<c-o>', opts)

-- Options
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.python3_host_prog = vim.env.HOME .. '/.local/venvs/nvim/bin/python'
vim.opt.clipboard:append('unnamedplus')
vim.opt.cmdheight = 2
vim.opt.confirm = true
vim.opt.cursorline = true
vim.opt.foldenable = false
vim.opt.foldmethod = 'indent'
vim.opt.hidden = true
vim.opt.ignorecase = true
vim.opt.linebreak = true
vim.opt.list = true
vim.opt.mouse = 'a'
vim.opt.number = true
vim.opt.path:append('**')
vim.opt.scrolloff = 3
vim.opt.showmatch = true
vim.opt.smartcase = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.termguicolors = true

-- Indentation
vim.opt.expandtab = false
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.cmd([[
	"" Set local indentation preferences *after* ftplugins
	"" but *before* plugin scripts (eg, sleuth, editorconfig)
	filetype plugin indent on
	autocmd FileType * setlocal expandtab< shiftwidth< softtabstop< tabstop<
]])
