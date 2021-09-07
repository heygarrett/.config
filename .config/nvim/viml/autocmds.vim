autocmd BufReadPost * if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit' | exe "normal! g`\"" | endif

filetype plugin indent on
autocmd FileType * setlocal noexpandtab tabstop=4 softtabstop=4 shiftwidth=4

set termguicolors
packadd! dracula_pro
let g:dracula_colorterm = 0
colorscheme dracula_pro

" packer
autocmd BufWritePost plugins.lua source <afile> | PackerCompile

" nvim-lint
autocmd BufEnter,InsertLeave * lua require('lint').try_lint()
