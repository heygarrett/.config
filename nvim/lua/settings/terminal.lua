vim.api.nvim_create_autocmd("TermOpen", {
	group = vim.api.nvim_create_augroup("terminal", { clear = true }),
	callback = function()
		vim.api.nvim_command("startinsert")
		vim.opt.cursorline = false
		vim.opt.number = false
	end,
})
