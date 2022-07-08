vim.api.nvim_create_augroup("terminal", { clear = true })
vim.api.nvim_create_autocmd("TermOpen", {
	group = "terminal",
	callback = function()
		vim.api.nvim_command("startinsert")
		vim.opt.cursorline = false
		vim.opt.number = false
	end
})
