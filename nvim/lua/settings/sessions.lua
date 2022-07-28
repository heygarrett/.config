vim.api.nvim_create_user_command("Save", "mksession!", {})
vim.api.nvim_create_user_command("Load", "silent! source Session.vim", {})

vim.api.nvim_create_augroup("sessions", { clear = true })
vim.api.nvim_create_autocmd("VimEnter", {
	group = "sessions",
	nested = true,
	callback = function()
		if vim.fn.argc() == 0 then
			vim.api.nvim_command("Load")
		end
	end,
})
vim.api.nvim_create_autocmd("VimLeavePre", {
	group = "sessions",
	command = "Save",
})
