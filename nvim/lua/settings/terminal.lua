vim.api.nvim_create_autocmd("TermOpen", { command = "startinsert" })
vim.api.nvim_create_autocmd("TermOpen", {
	callback = function()
		vim.opt.cursorline = false
		vim.opt.number = false
	end
})
