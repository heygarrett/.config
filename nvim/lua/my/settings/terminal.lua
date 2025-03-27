local group = vim.api.nvim_create_augroup("terminal", { clear = true })
vim.api.nvim_create_autocmd("TermOpen", {
	desc = "terminal options",
	group = group,
	callback = function()
		vim.cmd.startinsert()
	end,
})

local floating_terminal_state = {
	buf = -1,
	win = -1,
	insert = nil,
	winview = nil,
}
vim.keymap.set({ "n", "t" }, "<c-w><space>", function()
	if not vim.api.nvim_win_is_valid(floating_terminal_state.win) then
		if not vim.api.nvim_buf_is_valid(floating_terminal_state.buf) then
			floating_terminal_state.buf = vim.api.nvim_create_buf(false, true)
		end

		local height = math.floor(vim.o.lines * 0.85)
		local width = math.floor(vim.o.columns * 0.85)
		floating_terminal_state.win =
			vim.api.nvim_open_win(floating_terminal_state.buf, true, {
				relative = "editor",
				border = "rounded",
				height = height,
				width = width,
				row = math.floor((vim.o.lines - height) / 3),
				col = math.floor((vim.o.columns - width) / 2),
			})
		vim.wo[floating_terminal_state.win].winhl = "Normal:MyHighlight"

		if vim.bo[floating_terminal_state.buf].buftype ~= "terminal" then
			vim.cmd.terminal()
		elseif floating_terminal_state.insert then
			vim.cmd.startinsert()
		else
			vim.fn.winrestview(floating_terminal_state.winview)
		end
	else
		floating_terminal_state.insert = (vim.api.nvim_get_mode().mode == "t")
		if not floating_terminal_state.insert then
			floating_terminal_state.winview = vim.fn.winsaveview()
		end

		vim.api.nvim_win_hide(floating_terminal_state.win)
	end
end, { desc = "toggle floating terminal" })
