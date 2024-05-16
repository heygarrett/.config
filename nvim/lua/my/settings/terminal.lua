local group = vim.api.nvim_create_augroup("terminal", { clear = true })

vim.api.nvim_create_autocmd("TermOpen", {
	desc = "terminal options",
	group = group,
	callback = function()
		vim.cmd.startinsert()
		vim.o.cursorline = false
		vim.o.number = false
	end,
})
