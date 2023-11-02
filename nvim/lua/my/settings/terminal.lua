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

vim.api.nvim_create_autocmd("TermClose", {
	desc = "close terminal when process ends",
	group = group,
	callback = function(tbl)
		if vim.bo[tbl.buf].buftype == "terminal" then
			-- nvim errors on exit without force
			vim.api.nvim_buf_delete(tbl.buf, { force = true })
		end
	end,
})
