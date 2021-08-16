" --------------------------------------------------------------------------------
"  plugins
" --------------------------------------------------------------------------------

"" Update plugins
function! Update()
	PlugUpgrade
	PlugClean
	PlugUpdate --sync
	CocUpdate
	UpdateRemotePlugins
endfunction
command! Update call Update()

"" vim-plug settings
call plug#begin('~/.local/share/nvim/plugged')

Plug 'junegunn/vim-plug'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'itchyny/lightline.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-markdown'
Plug 'apple/swift', { 'rtp': 'utils/vim' }

call plug#end()

"" lightline.vim settings
function! CocCurrentFunction()
	return get(b:, 'coc_current_function', '')
endfunction

let g:lightline = {
	\ 'colorscheme': 'dracula_pro',
	\ 'active': {
		\ 'left': [ [ 'mode', 'paste' ],
		\ [ 'cocstatus', 'currentfunction', 'readonly', 'filename', 'modified' ] ]
	\ },
	\ 'component_function': {
		\ 'filename': 'LightlineFileFormat',
		\ 'cocstatus': 'coc#status',
		\ 'currentfunction': 'CocCurrentFunction'
	\ }
\ }

function! LightlineFileFormat()
	if &filetype ==# 'netrw'
		return getcwd()
	else
		return expand('%:F')
endfunction

set noshowmode

"" coc.nvim settings
" Extensions
let g:coc_global_extensions = [
	\ 'coc-marketplace',
	\ 'coc-tag',
	\ 'coc-snippets',
	\ 'coc-json',
	\ 'coc-sh',
	\ 'coc-sourcekit',
	\ 'coc-rust-analyzer',
	\ 'coc-eslint',
	\ 'coc-pyright',
\ ]

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
	\ pumvisible() ? "\<C-n>" :
	\ <SID>check_back_space() ? "\<TAB>" :
	\ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <CR> to confirm selected snippet or enter line break depending
inoremap <expr> <cr> pumvisible() ? (coc#rpc#request('hasSelected', []) ? "\<C-y>" : "\<CR>") : "\<C-g>u\<CR>"

" Use <tab> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<tab>'

" Use <s-tab> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<s-tab>'

" --------------------------------------------------------------------------------
"  languages
" --------------------------------------------------------------------------------
let g:python3_host_prog = "~/.local/venvs/nvim/bin/python"

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

hi link CocFloating markdown
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

