vim.opt.expandtab = false
vim.opt.shiftwidth = 0
vim.opt.softtabstop = -1
vim.opt.tabstop = 4
-- Set indentation *after* ftplugins
vim.api.nvim_create_autocmd('FileType', {
	callback = function()
		vim.opt_local.expandtab = nil
		vim.opt_local.shiftwidth = nil
		vim.opt_local.softtabstop = nil
		vim.opt_local.tabstop = nil
	end
})
