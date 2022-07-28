vim.api.nvim_create_augroup("sessions", { clear = true })
vim.api.nvim_create_autocmd("VimEnter", {
	group = "sessions",
	nested = true,
	callback = function()
		if vim.fn.argc() == 0 then
			vim.api.nvim_command("silent! source Session.vim")
		end
	end,
})
vim.api.nvim_create_autocmd("VimLeavePre", {
	group = "sessions",
	command = "mksession!",
})
