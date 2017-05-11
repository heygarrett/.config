" -------------------------------------------------------------------------------- 
"  plugins
" --------------------------------------------------------------------------------
" " Pathogen
" runtime bundle/pathogen/autoload/pathogen.vim
" execute pathogen#infect()
"
"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/Users/Garrett/repos/dotfiles/nvim/bundle//repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/Users/Garrett/repos/dotfiles/nvim/bundle/')
  call dein#begin('/Users/Garrett/repos/dotfiles/nvim/bundle/')

  " Let dein manage dein
  " Required:
  call dein#add('/Users/Garrett/repos/dotfiles/nvim/bundle//repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here:
  " call dein#add('Shougo/neosnippet.vim')
  " call dein#add('Shougo/neosnippet-snippets')
  call dein#add('itchyny/lightline.vim')
  call dein#add('altercation/vim-colors-solarized')
  call dein#add('ervandew/supertab')
  " call dein#add('pgdouyon/vim-accio')
  call dein#add('vim-syntastic/syntastic')
  call dein#add('~/repos/dotfiles/nvim/bundle/swift')
  call dein#add('kballard/vim-swift')
  let g:syntastic_swift_checkers = ['swiftc']

  " You can specify revision/branch/tag.
  " call dein#add('Shougo/vimshell', { 'rev': '3787e5' })

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

" Lightline
let g:lightline = {'colorscheme': 'solarized'}

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
set bg=dark
colorscheme solarized
 
" " Change the Solarized background to dark or light depending upon the time of 
" " day (5 refers to 5AM and 17 to 5PM). Change the background only if it is not 
" " already set to the value we want.
" function! SetSolarizedBackground()
"     if strftime("%H") >= 5 && strftime("%H") < 17 
"         if &background != 'light'
"             set background=light
"         endif
"     else
"         if &background != 'dark'
"             set background=dark
"         endif
"     endif
" endfunction
" 
" " Set background on launch
" call SetSolarizedBackground()
"  
" " Every time you save a file, call the function to check the time and change 
" " the background (if necessary).
" if has("autocmd")
"     autocmd bufwritepost * call SetSolarizedBackground()
" endif

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

autocmd filetype php setlocal filetype=html
syntax enable    " enable syntax highlighting and allow custom highlighting
set hlsearch    " highlight search terms
set ignorecase  " ignore case in searches
set smartcase   " unless there are caps in the search
set cursorline

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
set noshowmode   " let powerline show current mode (insert, visual, etc.)

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
set omnifunc=syntaxcomplete#Complete    " omni completion

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

set tabstop=8                " width of a tab character in spaces
set softtabstop=4            " defines number of spaces for when adding/removing tabs
set shiftwidth=4             " number of spaces to use for autoindent
set expandtab                " use spaces instead of tab characters; to insert real tab, use <C-v><Tab>
set autoindent
set smarttab

" Haskell indentation
let g:haskell_indent_if = 4
let g:haskell_indent_case = 4

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
inoremap {<CR>  {<CR>}<Esc>O
inoremap ,/ </<C-X><C-O>
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
