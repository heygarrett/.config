local sessions = vim.api.nvim_create_augroup("sessions", { clear = true })
-- If launched without args load or create session
vim.api.nvim_create_autocmd("VimEnter", {
	group = sessions,
	nested = true,
	callback = function()
		if vim.fn.argc() == 0 then
			if vim.fn.filereadable("Session.vim") == 1 then
				vim.api.nvim_command("source Session.vim")
			else
				vim.api.nvim_command("mksession")
			end
		end
	end,
})
-- Overwrite existing session when exiting
vim.api.nvim_create_autocmd("VimLeavePre", {
	group = sessions,
	callback = function()
		if vim.fn.filereadable("Session.vim") == 1 then
			vim.api.nvim_command("mksession!")
		end
	end,
})
