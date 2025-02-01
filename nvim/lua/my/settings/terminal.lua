local group = vim.api.nvim_create_augroup("terminal", { clear = true })
vim.api.nvim_create_autocmd("TermOpen", {
	desc = "terminal options",
	group = group,
	callback = function()
		vim.o.cursorline = false
		vim.o.number = false
		vim.cmd.startinsert()
	end,
})

local floating_terminal_state = {
	buf = -1,
	win = -1,
	winview = nil,
	insert = false,
}
vim.keymap.set({ "n", "t" }, "<c-w><space>", function()
	if vim.api.nvim_win_is_valid(floating_terminal_state.win) then
		floating_terminal_state.winview = vim.fn.winsaveview()
		floating_terminal_state.insert = (vim.api.nvim_get_mode().mode == "t")

		vim.api.nvim_win_hide(floating_terminal_state.win)
	else
		---@type integer
		local buf
		if vim.api.nvim_buf_is_valid(floating_terminal_state.buf) then
			buf = floating_terminal_state.buf
		else
			buf = vim.api.nvim_create_buf(false, true)
		end

		local height = math.floor(vim.o.lines * 0.85)
		local width = math.floor(vim.o.columns * 0.85)
		local win = vim.api.nvim_open_win(buf, true, {
			relative = "editor",
			height = height,
			width = width,
			row = math.floor((vim.o.lines - height) / 3),
			col = math.floor((vim.o.columns - width) / 2),
			border = "rounded",
		})
		vim.wo[win].winhl = "Normal:MyHighlight"

		floating_terminal_state.buf = buf
		floating_terminal_state.win = win

		if vim.bo[buf].buftype ~= "terminal" then
			vim.cmd.terminal()
		elseif floating_terminal_state.insert then
			vim.cmd.startinsert()
		else
			vim.fn.winrestview(floating_terminal_state.winview)
		end
	end
end, { desc = "toggle floating terminal" })
