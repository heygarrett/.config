vim.api.nvim_create_autocmd("TermOpen", {
	group = vim.api.nvim_create_augroup("terminal", { clear = true }),
	callback = function()
		vim.api.nvim_cmd({ cmd = "startinsert" }, { output = false })
		vim.opt.cursorline = false
		vim.opt.number = false
	end,
})
