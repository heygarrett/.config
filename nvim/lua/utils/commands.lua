vim.cmd([[command! -nargs=+ Ggrep execute 'silent grep! -r <args> .' | copen]])
vim.cmd([[command! -nargs=+ Ghelpgrep execute 'helpgrep <args>' | copen]])
