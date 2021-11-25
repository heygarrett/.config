vim.opt.expandtab = false
vim.opt.shiftwidth = 0
vim.opt.softtabstop = -1
vim.opt.tabstop = 4
-- Set indentation *after* ftplugins
vim.api.nvim_command([[au FileType * setl expandtab< shiftwidth< softtabstop< tabstop<]])
