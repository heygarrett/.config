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
local opts = { noremap = true, silent = true }
map('i', '<c-space>', '<c-x><c-o>', opts)
map('n', '<leader>-', '<cmd>e %:h<cr>', opts)
map('n', '<s-tab>', '<c-o>', opts)
map('n', 'j', 'gj', opts)
map('n', 'k', 'gk', opts)

-- Options
vim.g.netrw_banner = 0
vim.g.python3_host_prog = vim.env.HOME .. '/.local/venvs/nvim/bin/python'
vim.opt.breakindent = true
vim.opt.clipboard:append('unnamedplus')
vim.opt.completeopt = { 'menuone', 'noselect' }
vim.opt.confirm = true
vim.opt.cursorline = true
vim.opt.ignorecase = true
vim.opt.keywordprg = ':help'
vim.opt.linebreak = true
vim.opt.list = true
vim.opt.listchars = { tab = '| ', lead = '·', trail = '·', eol = '$' }
vim.opt.mouse = 'a'
vim.opt.number = true
vim.opt.path:append('**')
vim.opt.scrolloff = 3
vim.opt.shortmess:append('c')
vim.opt.showmatch = true
vim.opt.smartcase = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.termguicolors = true

-- Plugins
require('plugins/packer')
