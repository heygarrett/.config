" -------------------------------------------------------------------------------- 
"  important
" --------------------------------------------------------------------------------
" Pathogen
runtime bundle/pathogen/autoload/pathogen.vim
execute pathogen#infect()

" lightline
let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ 'component': {
      \   'readonly': '%{&readonly?"⭤":""}',
      \ },
      \ 'separator': { 'left': '⮀', 'right': '⮂' },
      \ 'subseparator': { 'left': '⮁', 'right': '⮃' }
      \ }

" neocomplete
let g:neocomplete#enable_at_startup = 1
" Use smartcase
let g:neocomplete#enable_smart_case = 1
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()
" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"
" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

set nocompatible    " Better safe than sorry

" set paste to prevent unexpected code formatting when pasting text
" toggle paste and show current value ('pastetoggle' doesn't)
nnoremap <Leader>p :set paste! paste?<CR>

" " Source the vimrc file after saving it
" if has("autocmd")
"   autocmd bufwritepost .vimrc source %
" endif

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
colorscheme solarized
 
" Change the Solarized background to dark or light depending upon the time of 
" day (5 refers to 5AM and 17 to 5PM). Change the background only if it is not 
" already set to the value we want.
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
filetype plugin indent on   " let vim detect filetype and load appropriate scripts
autocmd filetype php setlocal filetype=html
let g:syntastic_javascript_checkers = ['jshint']
syntax enable    " enable syntax highlighting and allow custom highlighting
set spell
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
set tabstop=8                " width of a tab character in spaces
set softtabstop=4            " defines number of spaces for when adding/removing tabs
set shiftwidth=4             " number of spaces to use for autoindent
set expandtab                " use spaces instead of tab characters; to insert real tab, use <C-v><Tab>
set cindent
set smartindent              " automatic indenting; see ':h C-indenting' for comparison
set autoindent
set smarttab

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
inoremap jj <Esc>
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
