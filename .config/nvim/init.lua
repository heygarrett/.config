require('plugins/packer')
require('plugins/lspconfig')
require('plugins/efm-langserver')
require('utils/diagnostic-signs')
require('plugins/lualine')
require('plugins/indexed-search')
require('plugins/telescope')
require('plugins/treesitter')

-- Colorscheme
vim.api.nvim_command('colorscheme dracula_pro')

-- Mappings
local map = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}
map('n', 'j', 'gj', opts)
map('n', 'k', 'gk', opts)
map('n', '<s-tab>', '<c-o>', opts)

-- Options
vim.g.python3_host_prog = vim.env.HOME .. '/.local/venvs/nvim/bin/python'
vim.g.netrw_liststyle = 3
vim.g.netrw_banner = 0
vim.opt.hidden = true
vim.opt.path:append('**')
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
vim.opt.clipboard:append('unnamedplus')
vim.opt.mouse = 'a'

-- Indentation
vim.opt.expandtab = false
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.cmd([[
	"" Set local indentation preferences *after* ftplugins
	"" but *before* plugin scripts (eg, sleuth, editorconfig)
	filetype plugin indent on
	autocmd FileType * setlocal expandtab< tabstop< softtabstop< shiftwidth<
]])
