" --------------------------------------------------------------------------------
"  plugins
" --------------------------------------------------------------------------------
autocmd BufWritePost plugins.lua source <afile> | PackerCompile

lua << EOF
require('plugins')

vim.g.coq_settings = {
	['auto_start'] = true,
	['clients.tmux.enabled'] = false,
	['clients.snippets.enabled'] = false,
	['keymap.jump_to_mark'] = '<c-n>',
}
local coq = require 'coq'
local nvim_lsp = require 'lspconfig'
local capabilities = vim.lsp.protocol.make_client_capabilities()
local on_attach = function(client, bufnr)
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
	local opts = { noremap=true, silent=true }

	buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
	buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	buf_set_keymap('n', '<Leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	buf_set_keymap('n', '<Leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
	buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
	buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
	buf_set_keymap('n', '<Leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
	buf_set_keymap('n', '<Leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

local servers = {
	'pyright',
	'rust_analyzer',
	'sourcekit',
	'tsserver',
}
for _, lsp in ipairs(servers) do
	nvim_lsp[lsp].setup(coq.lsp_ensure_capabilities({
		on_attach = on_attach,
		capabilities = capabilities
	}))
end

local lint = require('lint')
lint.linters_by_ft = {
	javascript = {'eslint'},
	typescript = {'eslint'},
}
lint.linters.eslint.cmd = './node_modules/.bin/eslint'
vim.cmd([[au BufEnter,InsertLeave * lua require('lint').try_lint()]])

local signs = { Error = '🚫', Warning = '⚠️', Hint = '💡', Information = 'ℹ️' }
for type, icon in pairs(signs) do
	local hl = "LspDiagnosticsSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
EOF

let g:lightline = {
	\ 'colorscheme': 'dracula_pro',
	\ 'active': {
		\ 'left': [ [ 'mode', 'paste' ],
		\ [ 'currentfunction', 'readonly', 'filename', 'modified' ] ]
	\ },
	\ 'component_function': {
		\ 'filename': 'LightlineFileFormat'
	\ }
\ }

function! LightlineFileFormat()
	if &filetype ==# 'netrw'
		return getcwd()
	else
		return expand('%:F')
endfunction


" --------------------------------------------------------------------------------
"  misc. functionality
" --------------------------------------------------------------------------------
set noshowmode
set signcolumn=yes
set cmdheight=2
set confirm
let g:indexed_search_numbered_only = 1

" --------------------------------------------------------------------------------
"  languages
" --------------------------------------------------------------------------------
let g:python3_host_prog = $HOME . "/.local/venvs/nvim/bin/python"

" --------------------------------------------------------------------------------
"  netrw
" --------------------------------------------------------------------------------
autocmd FileType netrw setlocal nocursorcolumn
let g:netrw_liststyle = 3
" let g:netrw_keepdir=0

" --------------------------------------------------------------------------------
"  displaying text
" --------------------------------------------------------------------------------
set termguicolors
"" colorscheme dracula pro
packadd! dracula_pro
let g:dracula_colorterm = 0
colorscheme dracula_pro

set number
set scrolloff=3
set linebreak

set list

" --------------------------------------------------------------------------------
"  syntax, highlighting, and spelling
" --------------------------------------------------------------------------------
set ignorecase
set smartcase
set cursorline
" set cursorcolumn

highlight clear SignColumn

" --------------------------------------------------------------------------------
"  multiple windows
" --------------------------------------------------------------------------------
set laststatus=2
set splitbelow
set splitright
set hidden

" --------------------------------------------------------------------------------
"  terminal
" --------------------------------------------------------------------------------
autocmd TermOpen * startinsert
autocmd TermOpen * setlocal nonumber nocursorline nocursorcolumn
set title

" --------------------------------------------------------------------------------
"  using the mouse
" --------------------------------------------------------------------------------
set mouse=a

" --------------------------------------------------------------------------------
"  selecting text
" --------------------------------------------------------------------------------
set clipboard+=unnamedplus

" --------------------------------------------------------------------------------
"  editing text
" --------------------------------------------------------------------------------
set showmatch

" When editing a file, always jump to the last cursor position
autocmd BufReadPost *
	\ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
	\ |   exe "normal! g`\""
	\ | endif

" --------------------------------------------------------------------------------
"  tabs and indenting
" --------------------------------------------------------------------------------
" Indenting defaults (does not override vim-sleuth's indenting detection)
filetype plugin indent on
autocmd FileType * setlocal noexpandtab tabstop=4 softtabstop=4 shiftwidth=4

" --------------------------------------------------------------------------------
"  folding
" --------------------------------------------------------------------------------
set foldmethod=indent
set nofoldenable

" --------------------------------------------------------------------------------
"  mapping
" --------------------------------------------------------------------------------
nmap j gj
nmap k gk

" --------------------------------------------------------------------------------
"  command line editing
" --------------------------------------------------------------------------------
set history=1000
set undolevels=1000

