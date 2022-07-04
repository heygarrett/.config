vim.opt.expandtab = false
vim.opt.shiftwidth = 0
vim.opt.softtabstop = -1
vim.opt.tabstop = 4

vim.api.nvim_create_augroup("indentation", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	group = "indentation",
	callback = function()
		-- Override ftplugin indentation settings
		vim.opt_local.expandtab = vim.opt_global.expandtab:get()
		vim.opt_local.shiftwidth = vim.opt_global.shiftwidth:get()
		vim.opt_local.softtabstop = vim.opt_global.softtabstop:get()
		vim.opt_local.tabstop = vim.opt_global.tabstop:get()
		-- Use | for tabs and · for blocks of spaces
		local ms = "·" .. string.rep(" ", vim.opt.tabstop:get() - 1)
		vim.opt.listchars = { tab = "| ", multispace = ms, trail = "·" }
	end
})
