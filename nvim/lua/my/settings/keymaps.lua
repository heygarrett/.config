vim.keymap.set("i", "<c-space>", function()
	vim.lsp.completion.get()
end, { desc = "LSP completion" })

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
