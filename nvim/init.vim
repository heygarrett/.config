" --------------------------------------------------------------------------------
"  plugins
" --------------------------------------------------------------------------------

"" vim-plug settings
call plug#begin('~/.local/share/nvim/plugged')

" Plugin/extension management
Plug 'junegunn/vim-plug'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Visuals
Plug 'altercation/solarized', { 'rtp': 'vim-colors-solarized' }
Plug 'itchyny/lightline.vim'
Plug 'thaerkh/vim-indentguides'
Plug 'apple/swift', { 'rtp': 'utils/vim' }

" Functionality
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-fugitive'

call plug#end()

"" lightline.vim settings
function! CocCurrentFunction()
	return get(b:, 'coc_current_function', '')
endfunction

let g:lightline = {
	\ 'colorscheme': 'solarized',
	\ 'active': {
		\ 'left': [ [ 'mode', 'paste' ],
		\ [ 'cocstatus', 'currentfunction', 'readonly', 'filename', 'modified' ] ]
	\ },
	\ 'component_function': {
		\ 'cocstatus': 'coc#status',
		\ 'currentfunction': 'CocCurrentFunction'
	\ },
\ }

set noshowmode

"" coc.nvim settings

" Extensions
let g:coc_global_extensions = [
	\ 'coc-marketplace',
	\ 'coc-explorer',
	\ 'coc-tag',
	\ 'coc-snippets',
	\ 'coc-json',
	\ 'coc-sh',
	\ 'coc-sourcekit',
	\ 'coc-rust-analyzer',
	\ 'coc-tsserver',
\ ]

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
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
"  displaying text
" --------------------------------------------------------------------------------
" Set colorscheme to solarized
colorscheme solarized

set linebreak   " wrap long lines at a blank
set t_Co=256
set scrolloff=3
set number       " show line numbers

" --------------------------------------------------------------------------------
"  syntax, highlighting, and spelling
" --------------------------------------------------------------------------------
" Completion
set omnifunc=syntaxcomplete#Complete

set ignorecase  " ignore case in searches
set smartcase   " unless there are caps in the search
set cursorline

hi link CocFloating markdown
highlight clear SignColumn

" --------------------------------------------------------------------------------
"  multiple windows
" --------------------------------------------------------------------------------
set laststatus=2 " always show status line
set splitbelow
set splitright
set hidden

" --------------------------------------------------------------------------------
"  multiple tab pages
" --------------------------------------------------------------------------------
set showtabline=1

" --------------------------------------------------------------------------------
"  terminal
" --------------------------------------------------------------------------------
set title        " set title to filename and modification status

" --------------------------------------------------------------------------------
"  using the mouse
" --------------------------------------------------------------------------------
set mouse=a

" --------------------------------------------------------------------------------
"  selecting text
" --------------------------------------------------------------------------------
" --copying / pasting
set clipboard+=unnamedplus

" --------------------------------------------------------------------------------
"  editing text
" --------------------------------------------------------------------------------
set showmatch                           " show matching braces when typed or under cursor
set matchtime=2                         " length of time for 'showmatch'

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
"" Indenting defaults (does not override vim-sleuth's indenting detection)
if get(g:, '_has_set_default_indent_settings', 0) == 0
	autocmd FileType * setlocal noexpandtab tabstop=4 shiftwidth=4
	let g:_has_set_default_indent_settings = 1
endif

""" set noexpandtab
""" set tabstop=4                " width of a tab character in spaces
""" set shiftwidth=4             " number of spaces to use for autoindent

" --------------------------------------------------------------------------------
"  folding
" --------------------------------------------------------------------------------
set fdm=indent
set foldnestmax=3   " maximum fold depth
set nofoldenable      " set to display all folds open

" --------------------------------------------------------------------------------
"  mapping
" --------------------------------------------------------------------------------
nmap j gj
nmap k gk

" --------------------------------------------------------------------------------
"  command line editing
" --------------------------------------------------------------------------------
set history=1000    " history of commands and searches
set undolevels=1000 " changes to be remembered

