vim.keymap.set("i", "<cr>", function()
	local pum_info = vim.fn.complete_info({ "mode", "selected" })
	if pum_info.mode ~= "" and pum_info.selected == -1 then
		return "<c-e><cr>"
	else
		return "<cr>"
	end
end, {
	expr = true,
	desc = "workaround for pop-up menu issue in vim",
	-- HACK: https://github.com/vim/vim/issues/1653
})

vim.keymap.set("i", "<c-space>", "<c-x><c-o>", { desc = "omnicompletion" })

vim.keymap.set("v", "zz", function()
	local first_line = vim.fn.getpos("v")[2]
	local last_line = vim.fn.getpos(".")[2]
	local middle_line = math.floor((first_line + last_line) / 2)
	vim.cmd.normal({
		args = { vim.keycode("<esc>") },
	})
	vim.api.nvim_win_set_cursor(0, { middle_line, 0 })
	vim.cmd.normal({
		args = { "zz" },
	})
	vim.cmd.normal({
		args = { "gv" },
	})
end, { desc = "vertically center visual selection" })

vim.keymap.set({ "n", "t" }, "<c-w><space>", function()
	if not vim.g.floating_terminal then
		vim.g.floating_terminal = {
			buf = -1,
			win = -1,
			winview = nil,
			insert = false,
		}
	end

	if vim.api.nvim_win_is_valid(vim.g.floating_terminal.win) then
		vim.g.floating_terminal = {
			buf = vim.g.floating_terminal.buf,
			win = vim.g.floating_terminal.win,
			winview = vim.fn.winsaveview(),
			insert = (vim.api.nvim_get_mode().mode == "t"),
		}
		vim.api.nvim_win_hide(vim.g.floating_terminal.win)
	else
		---@type integer
		local buf
		if vim.api.nvim_buf_is_valid(vim.g.floating_terminal.buf) then
			buf = vim.g.floating_terminal.buf
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

		vim.g.floating_terminal = {
			buf = buf,
			win = win,
			winview = vim.g.floating_terminal.winview,
			insert = vim.g.floating_terminal.insert,
		}

		if vim.bo[buf].buftype ~= "terminal" then
			vim.cmd.terminal()
		elseif vim.g.floating_terminal.insert then
			vim.cmd.startinsert()
		else
			vim.fn.winrestview(vim.g.floating_terminal.winview)
		end
	end
end, { desc = "toggle floating terminal" })
