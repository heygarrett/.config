-- Guard against file args and nvim launched by git
local function args_or_git()
	local parent_command =
		vim.fn.system("ps -o ppid= -p $fish_pid | xargs ps -o comm= -p")
	return vim.fn.argc() ~= 0 or not parent_command:match("^nvim")
end

local sessions = vim.api.nvim_create_augroup("sessions", { clear = true })
-- Load or create session
vim.api.nvim_create_autocmd("VimEnter", {
	group = sessions,
	nested = true,
	callback = function()
		if args_or_git() then return end
		if vim.fn.filereadable("Session.vim") == 1 then
			vim.api.nvim_command("source Session.vim")
		else
			vim.api.nvim_command("mksession")
		end
	end,
})
-- Overwrite existing session when exiting
vim.api.nvim_create_autocmd("VimLeavePre", {
	group = sessions,
	callback = function()
		if args_or_git() then return end
		if vim.fn.filereadable("Session.vim") == 1 then
			vim.api.nvim_command("mksession!")
		end
	end,
})
