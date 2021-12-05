vim.api.nvim_command([[command! -nargs=+ Ggrep execute 'silent grep! -r <args> .' | copen]])
vim.api.nvim_command([[command! -nargs=+ Ghelpgrep execute 'helpgrep <args>' | copen]])
