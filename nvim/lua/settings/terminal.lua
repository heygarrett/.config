vim.api.nvim_create_augroup("terminal", { clear = true })

vim.api.nvim_create_autocmd("TermOpen", {
	desc = "terminal options",
	group = "terminal",
	callback = function()
		vim.cmd.startinsert()
		vim.o.cursorline = false
		vim.o.number = false
	end,
})

vim.api.nvim_create_autocmd("TermClose", {
	desc = "close terminal when process ends",
	group = "terminal",
	callback = function(tbl)
		if vim.bo[tbl.buf].buftype == "terminal" then
			vim.api.nvim_buf_delete(tbl.buf, {})
		end
	end,
})
