vim.opt.expandtab = false
vim.opt.shiftwidth = 0
vim.opt.softtabstop = -1
vim.opt.tabstop = 4
-- Set indentation *after* ftplugins
vim.api.nvim_create_autocmd('FileType', {
	callback = function()
		vim.opt_local.expandtab = vim.opt_global.expandtab:get()
		vim.opt_local.shiftwidth = vim.opt_global.shiftwidth:get()
		vim.opt_local.softtabstop = vim.opt_global.softtabstop:get()
		vim.opt_local.tabstop = vim.opt_global.tabstop:get()
	end
})
