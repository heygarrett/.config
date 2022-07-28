vim.api.nvim_create_user_command("Save", "mksession!", {})
vim.api.nvim_create_user_command("Load", "silent! source Session.vim", {})

vim.api.nvim_create_autocmd("VimLeavePre", {
	group = vim.api.nvim_create_augroup("sessions", { clear = true }),
	command = "Save",
})
