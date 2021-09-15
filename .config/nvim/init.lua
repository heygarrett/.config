require('plugins/packer')
require('plugins/lspconfig')
require('plugins/lualine')
require('plugins/indent-blankline')

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

vim.api.nvim_set_keymap('n', 'j', 'gj', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'k', 'gk', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>out', '<c-o>', {noremap = true, silent = true})

vim.cmd([[
	"" Restore last cursor position when opening a file
	autocmd BufReadPost * if line("'\"")>=1 && line("'\"")<=line("$") && &ft!~#'gitcommit' | exe "normal! g`\"" | endif

	"" Set local indentation preferences *after* ftplugins
	"" but *before* plugin scripts (eg, sleuth, editorconfig)
	filetype plugin indent on
	autocmd FileType * setlocal expandtab< tabstop< softtabstop< shiftwidth<

	packadd! dracula_pro
	let g:dracula_colorterm = 0
	colorscheme dracula_pro
]])
