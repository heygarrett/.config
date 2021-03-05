" -------------------------------------------------------------------------------- 
"  plugins
" --------------------------------------------------------------------------------

" ----------------------------
" Plug settings
call plug#begin('~/.local/share/nvim/plugged')
Plug 'junegunn/vim-plug'

Plug 'itchyny/lightline.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'apple/swift', { 'rtp': 'utils/vim' }
Plug 'editorconfig/editorconfig-vim'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

" / Plug settings
" ----------------------------

" ----------------------------
" Lightline settings (with some coc.nvim)
function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'currentfunction', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status',
      \   'currentfunction': 'CocCurrentFunction'
      \ },
      \ }

" / Lightline settings (with some coc.nvim)
" ----------------------------

" ----------------------------
" coc.nvim settings

" Extensions
let g:coc_global_extensions = [
		\ 'coc-json',
		\ 'coc-marketplace',
		\ 'coc-rust-analyzer',
		\ 'coc-sh',
		\ 'coc-snippets',
		\ 'coc-sourcekit',
		\ 'coc-tag'
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

" / coc.nvim settings
" ----------------------------


" -------------------------------------------------------------------------------- 
"  moving around, searching, and patterns
" -------------------------------------------------------------------------------- 

" -------------------------------------------------------------------------------- 
"  tags
" -------------------------------------------------------------------------------- 

" -------------------------------------------------------------------------------- 
"  displaying text
" -------------------------------------------------------------------------------- 
" Set colorscheme to solarized
" set background=dark
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
"  printing
" -------------------------------------------------------------------------------- 

" -------------------------------------------------------------------------------- 
"  messages and info
" -------------------------------------------------------------------------------- 

" -------------------------------------------------------------------------------- 
"  selecting text
" -------------------------------------------------------------------------------- 
" --copying / pasting
" allow vim commands to copy to system clipboard (*)
" for X11:
"   + is the clipboard register (Ctrl-{c,v})
"   * is the selection register (middle click, Shift-Insert)
set clipboard=unnamed

" use clipboard register when supported (X11 only)
if has("unnamedplus")
    set clipboard+=unnamedplus
endif
" Clipboard for neovim
function! ClipboardYank()
    call system('pbcopy', @@)
endfunction
function! ClipboardPaste()
    let @@ = system('pbpaste')
endfunction

" set paste to prevent unexpected code formatting when pasting text
" toggle paste and show current value ('pastetoggle' doesn't)
nnoremap <Leader>p :set paste! paste?<CR>

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

set noexpandtab
set tabstop=4                " width of a tab character in spaces
set shiftwidth=4             " number of spaces to use for autoindent

" -------------------------------------------------------------------------------- 
"  folding
" -------------------------------------------------------------------------------- 
set fdm=indent
set foldnestmax=3   " maximum fold depth
set nofoldenable      " set to display all folds open

" -------------------------------------------------------------------------------- 
"  diff mode
" -------------------------------------------------------------------------------- 

" -------------------------------------------------------------------------------- 
"  mapping
" -------------------------------------------------------------------------------- 
nmap j gj
nmap k gk

" -------------------------------------------------------------------------------- 
"  reading and writing files
" -------------------------------------------------------------------------------- 

" -------------------------------------------------------------------------------- 
"  the swap file
" -------------------------------------------------------------------------------- 
" set noswapfile

" -------------------------------------------------------------------------------- 
"  command line editing
" -------------------------------------------------------------------------------- 
set history=1000    " history of commands and searches
set undolevels=1000 " changes to be remembered

" -------------------------------------------------------------------------------- 
"  executing external commands
" -------------------------------------------------------------------------------- 

" -------------------------------------------------------------------------------- 
"  running make and jumping to errors
" -------------------------------------------------------------------------------- 

" -------------------------------------------------------------------------------- 
"  language specific
" -------------------------------------------------------------------------------- 

" -------------------------------------------------------------------------------- 
"  multi-byte characters
" -------------------------------------------------------------------------------- 

" -------------------------------------------------------------------------------- 
"  various
" -------------------------------------------------------------------------------- 
