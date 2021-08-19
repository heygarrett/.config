" --------------------------------------------------------------------------------
"  plugins
" --------------------------------------------------------------------------------
autocmd BufWritePost plugins.lua source <afile> | PackerCompile

lua << EOF
require('plugins')

vim.g.coq_settings = { ['auto_start'] = true, ['keymap.jump_to_mark'] = '<c-n>' }
local coq = require 'coq'
local nvim_lsp = require 'lspconfig'
local capabilities = vim.lsp.protocol.make_client_capabilities()

local servers = { 'pyright', 'rust_analyzer', 'sourcekit', 'tsserver' }
for _, lsp in ipairs(servers) do
	nvim_lsp[lsp].setup(coq.lsp_ensure_capabilities({
		capabilities = capabilities
	}))
end

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


set noshowmode
set signcolumn=yes
set cmdheight=2

" --------------------------------------------------------------------------------
"  languages
" --------------------------------------------------------------------------------
let g:python3_host_prog = $HOME . "/.local/venvs/nvim/bin/python"

" --------------------------------------------------------------------------------
"  netrw
" --------------------------------------------------------------------------------
autocmd FileType netrw setlocal nocursorcolumn
let g:netrw_keepdir=0

" --------------------------------------------------------------------------------
"  displaying text
" --------------------------------------------------------------------------------
"" colorscheme dracula pro
packadd! dracula_pro
let g:dracula_colorterm = 0
colorscheme dracula_pro

set number
set scrolloff=3
set linebreak

" --------------------------------------------------------------------------------
"  syntax, highlighting, and spelling
" --------------------------------------------------------------------------------
set ignorecase
set smartcase
set cursorline
set cursorcolumn

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
if has("autocmd")
	autocmd BufReadPost *
	\ if line("'\"") > 0 && line ("'\"") <= line("$") |
	\   exe "normal! g'\"" |
	\ endif
endif

" --------------------------------------------------------------------------------
"  tabs and indenting
" --------------------------------------------------------------------------------
" Indenting defaults (does not override vim-sleuth's indenting detection)
if get(g:, '_has_set_default_indent_settings', 0) == 0
	autocmd FileType * setlocal noexpandtab tabstop=4 shiftwidth=4
	set noexpandtab
	set tabstop=4
	set shiftwidth=4
	let g:_has_set_default_indent_settings = 1
endif

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

