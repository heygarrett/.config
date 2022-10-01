vim.api.nvim_create_autocmd("TermOpen", {
	group = vim.api.nvim_create_augroup("terminal", { clear = true }),
	callback = function()
		vim.cmd.startinsert()
		vim.o.cursorline = false
		vim.o.number = false
	end,
})
