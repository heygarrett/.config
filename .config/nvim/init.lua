-- Load packer first
require('plugins/packer')
-- Then the rest
require('plugins/indexed-search')
require('plugins/lsp_signature')
require('plugins/lspconfig')
require('plugins/lualine')
require('plugins/null-ls')
require('plugins/telescope')
require('plugins/treesitter')
require('plugins/vim-markdown')
require('utils/commands')
require('utils/diagnostic-signs')

-- Colorscheme
vim.api.nvim_command('colorscheme dracula_pro')

-- Indentation
vim.opt.expandtab = false
vim.opt.shiftwidth = 0
vim.opt.softtabstop = -1
vim.opt.tabstop = 4
-- Set indentation *after* ftplugins but *before* plugin scripts (eg, sleuth, editorconfig)
vim.cmd [[
	filetype plugin indent on
	autocmd FileType * set expandtab< shiftwidth< softtabstop< tabstop<
]]

-- Mappings
local map = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}
map('n', 'j', 'gj', opts)
map('n', 'k', 'gk', opts)
map('n', '<s-tab>', '<c-o>', opts)
map('i', '<c-p>', vim.fn.pumvisible() ~= 0 and '<c-p>' or '<c-x><c-o>', opts)

-- Options
vim.g.netrw_banner = 0
vim.g.python3_host_prog = vim.env.HOME .. '/.local/venvs/nvim/bin/python'
vim.opt.clipboard:append('unnamedplus')
vim.opt.completeopt = {'menuone', 'noselect', 'noinsert'} --, 'preview'}
vim.opt.confirm = true
vim.opt.cursorline = true
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
