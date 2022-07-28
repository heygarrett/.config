vim.api.nvim_create_augroup("sessions", { clear = true })
-- Load potential session when launched without args
vim.api.nvim_create_autocmd("VimEnter", {
	group = "sessions",
	nested = true,
	callback = function()
		if vim.fn.argc() == 0 then
			vim.api.nvim_command("silent! source Session.vim")
		end
	end,
})
-- Overwrite existing session when exiting
vim.api.nvim_create_autocmd("VimLeavePre", {
	group = "sessions",
	callback = function()
		if vim.fn.filereadable("Session.vim") == 1 then
			vim.api.nvim_command("mksession!")
		end
	end,
})
