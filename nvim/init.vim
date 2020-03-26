" -------------------------------------------------------------------------------- 
"  plugins
" --------------------------------------------------------------------------------
"
" " Plug
call plug#begin('~/.local/share/nvim/plugged')
Plug 'junegunn/vim-plug'

Plug 'itchyny/lightline.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'apple/swift', {'rtp': 'utils/vim'}
" Plug 'rust-lang/rust.vim'

" Plug 'lifepillar/vim-mucomplete'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'autozimu/LanguageClient-neovim', {
"     \ 'branch': 'next',
"     \ 'do': '`echo $SHELL` install.sh',
"     \ }
" " (Optional) Multi-entry selection UI.
" Plug 'junegunn/fzf'

call plug#end()

" Lightline
" let g:lightline = {'colorscheme': 'solarized'}
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

""" Trying coc.vim
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
" set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" " Use MUcomplete
" set completeopt+=menuone,noselect
" set shortmess+=c   " Shut off completion messages
" let g:mucomplete#enable_auto_at_startup = 1

" " Use LSP for language support
" let g:LanguageClient_serverCommands = {
"     \ 'rust': ['rustup', 'run', 'stable', 'rls'],
" 	\ 'python': ['/usr/local/bin/pyls'],
" 	\ 'go': ['gopls'],
"     \ }
" 
" nnoremap <F5> :call LanguageClient_contextMenu()<CR>

" Swift
let g:swift_suppress_showmatch_warning = 1
autocmd filetype swift setlocal colorcolumn=0 " get rid of the annoying vertical line

set nocompatible    " Better safe than sorry

" set paste to prevent unexpected code formatting when pasting text
" toggle paste and show current value ('pastetoggle' doesn't)
nnoremap <Leader>p :set paste! paste?<CR>

" -------------------------------------------------------------------------------- 
"  moving around, searching, and patterns
" -------------------------------------------------------------------------------- 
set incsearch   " highlight search while typing search pattern

" -------------------------------------------------------------------------------- 
"  tags
" -------------------------------------------------------------------------------- 

" -------------------------------------------------------------------------------- 
"  displaying text
" -------------------------------------------------------------------------------- 
" Set colorscheme to solarized
set background=dark
colorscheme solarized
 
" Toggle Solarized background
call togglebg#map("<F5>")

set linebreak   " wrap long lines at a blank
set t_Co=256
set scrolloff=3
set number       " show line numbers

" -------------------------------------------------------------------------------- 
"  syntax, highlighting, and spelling
" -------------------------------------------------------------------------------- 
" Completion
set omnifunc=syntaxcomplete#Complete
let g:SuperTabDefaultCompletionType = 'context'

syntax enable    " enable syntax highlighting and allow custom highlighting
set hlsearch    " highlight search terms
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
set ruler        " always show current position
set showcmd      " show the command being typed

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

" vnoremap <silent> y y:call ClipboardYank()<cr>
" vnoremap <silent> d d:call ClipboardYank()<cr>
" nnoremap <silent> p :call ClipboardPaste()<cr>p
" onoremap <silent> y y:call ClipboardYank()<cr>
" onoremap <silent> d d:call ClipboardYank()<cr>

" -------------------------------------------------------------------------------- 
"  editing text
" -------------------------------------------------------------------------------- 
set showmatch                           " show matching braces when typed or under cursor
set matchtime=2                         " length of time for 'showmatch'
set backspace=start,indent,eol          " make backspace work like 'normal' text editors

" Disable autocommenting after <CR> (//)
autocmd FileType c,cpp setlocal comments-=:// comments+=f://

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
filetype plugin indent on   " let vim detect filetype and load appropriate scripts

set tabstop=4                " width of a tab character in spaces
" set softtabstop=4            " defines number of spaces for when adding/removing tabs
set shiftwidth=4             " number of spaces to use for autoindent
" set expandtab                " use spaces instead of tab characters; to insert real tab, use <C-v><Tab>
set autoindent
set smarttab

" Haskell indentation
let g:haskell_indent_if = 4
let g:haskell_indent_case = 4

" Swift indents
autocmd filetype swift setlocal tabstop=4
autocmd filetype swift setlocal shiftwidth=4

" TypeScript indents
autocmd filetype typescript setlocal noexpandtab
autocmd filetype typescript setlocal tabstop=4
autocmd filetype typescript setlocal shiftwidth=4

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
imap jk <esc>
imap {<CR>  {<CR>}<Esc>O
imap ,/ </<C-X><C-O>
nmap j gj
nmap k gk

" -------------------------------------------------------------------------------- 
"  reading and writing files
" -------------------------------------------------------------------------------- 
set fileformats=unix,dos,mac    " try recognizing line endings in this order

" -------------------------------------------------------------------------------- 
"  the swap file
" -------------------------------------------------------------------------------- 
set noswapfile

" -------------------------------------------------------------------------------- 
"  command line editing
" -------------------------------------------------------------------------------- 
set history=1000    " history of commands and searches
set undolevels=1000 " changes to be remembered
set wildmenu    " use menu for command line completion

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
