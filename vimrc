" -------------------------------------------------------------------------------- 
"  important
" --------------------------------------------------------------------------------
runtime bundle/pathogen/autoload/pathogen.vim
execute pathogen#infect()
set nocompatible
" set paste to prevent unexpected code formatting when pasting text
" toggle paste and show current value ('pastetoggle' doesn't)
nnoremap <Leader>p :set paste! paste?<CR>

" -------------------------------------------------------------------------------- 
"  moving around, searching, and patterns
" -------------------------------------------------------------------------------- 

" -------------------------------------------------------------------------------- 
"  tags
" -------------------------------------------------------------------------------- 

" -------------------------------------------------------------------------------- 
"  displaying text
" -------------------------------------------------------------------------------- 
colorscheme solarized
set t_Co=256
set scrolloff=3
set number       " show line numbers

" -------------------------------------------------------------------------------- 
"  syntax, highlighting, and spelling
" -------------------------------------------------------------------------------- 
filetype plugin indent on   " let vim detect filetype and load appropriate scripts
syntax enable    " enable syntax highlighting and allow custom highlighting
set hlsearch    " highlight search terms
set ignorecase  " ignore case in searches
set smartcase   " unless there are caps in the search
set cursorline

" -------------------------------------------------------------------------------- 
"  multiple windows
" --------------------------------------------------------------------------------  
set laststatus=2 " always show status line

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
set showmode     " show current mode (insert, visual, etc.)

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

" -------------------------------------------------------------------------------- 
"  editing text
" -------------------------------------------------------------------------------- 
set showmatch   " show matching braces when typed or under cursor
set matchtime=2 " length of time for 'showmatch'
set backspace=start,indent,eol     " make backspace work like 'normal' text editors
set ofu=syntaxcomplete#Complete " omni completion

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
set tabstop=8                " width of a tab character in spaces
set softtabstop=4            " defines number of spaces for when adding/removing tabs
set shiftwidth=4             " number of spaces to use for autoindent
set expandtab                " use spaces instead of tab characters; to insert real tab, use <C-v><Tab>
set smartindent              " automatic indenting; see ':h C-indenting' for comparison
set autoindent
set smarttab

" -------------------------------------------------------------------------------- 
"  folding
" -------------------------------------------------------------------------------- 

" -------------------------------------------------------------------------------- 
"  diff mode
" -------------------------------------------------------------------------------- 

" -------------------------------------------------------------------------------- 
"  mapping
" -------------------------------------------------------------------------------- 
inoremap jj <Esc>
inoremap ,/ </<C-X><C-O>
nmap j gj
nmap k gk

" -------------------------------------------------------------------------------- 
"  reading and writing files
" -------------------------------------------------------------------------------- 
set fileformats=unix,dos,mac " try recognizing line endings in this order

" -------------------------------------------------------------------------------- 
"  the swap file
" -------------------------------------------------------------------------------- 
set noswapfile

" -------------------------------------------------------------------------------- 
"  command line editing
" -------------------------------------------------------------------------------- 
set history=500    " history of commands and searches
set undolevels=500 " changes to be remembered

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

