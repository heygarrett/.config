vim.opt.expandtab = false
vim.opt.shiftwidth = 0
vim.opt.softtabstop = -1
vim.opt.tabstop = 4
-- Set indentation *after* ftplugins but *before* plugin scripts (eg, sleuth, editorconfig)
vim.api.nvim_command([[au! FileType * set expandtab< shiftwidth< softtabstop< tabstop<]])
