" --------------------------------------------------------------------------------
"  plugins
" --------------------------------------------------------------------------------

"" Update plugins
function! Update()
	PlugUpgrade
	PlugClean
	PlugUpdate --sync
	UpdateRemotePlugins
endfunction
command! Update call Update()

"" vim-plug settings
call plug#begin('~/.local/share/nvim/plugged')

" Plugin/extension management
Plug 'junegunn/vim-plug'
Plug 'neovim/nvim-lspconfig'
Plug 'ms-jpq/coq_nvim', {'branch': 'coq', 'do': ':COQnow'}
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}

" Visuals
Plug 'altercation/solarized', { 'rtp': 'vim-colors-solarized' }
Plug 'itchyny/lightline.vim'
Plug 'apple/swift', { 'rtp': 'utils/vim' }

" Functionality
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-markdown'

call plug#end()

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

lua << EOF
local lsp = require "lspconfig"
lsp.pyright.setup({}) -- (coq.lsp_ensure_capabilities({}))
lsp.rust_analyzer.setup({}) -- (coq.lsp_ensure_capabilities({}))
lsp.tsserver.setup({}) -- (coq.lsp_ensure_capabilities({}))
lsp.sourcekit.setup({}) -- (coq.lsp_ensure_capabilities({}))
lsp.jsonls.setup({}) -- (coq.lsp_ensure_capabilities({}))
lsp.bashls.setup({}) -- (coq.lsp_ensure_capabilities({}))

EOF

set noshowmode

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" --------------------------------------------------------------------------------
"  languages
" --------------------------------------------------------------------------------
" let g:python3_host_prog = "~/.local/venvs/nvim/bin/python"

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
" Completion
set omnifunc=syntaxcomplete#Complete

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

