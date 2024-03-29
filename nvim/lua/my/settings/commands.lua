vim.api.nvim_create_user_command("Sort", function(t)
	local line_list = vim.api.nvim_buf_get_lines(0, t.line1 - 1, t.line2, true)
	table.sort(line_list, function(a, b)
		local a_len = vim.fn.strdisplaywidth(a)
		local b_len = vim.fn.strdisplaywidth(b)
		if a_len == b_len then
			return a < b
		elseif t.bang then
			return a_len > b_len
		else
			return a_len < b_len
		end
	end)
	vim.api.nvim_buf_set_lines(0, t.line1 - 1, t.line2, true, line_list)
end, {
	range = "%",
	bang = true,
	desc = "sort lines by length",
})

vim.api.nvim_create_user_command("Gobble", function(tbl)
	local line_list =
		vim.api.nvim_buf_get_lines(0, tbl.line1 - 1, tbl.line2, true)
	local global_depth = 0
	for _, line in ipairs(line_list) do
		if #line == 0 then
			goto continue
		end
		local leading_whitespace = line:match("^%s+")
		-- Exit early if there's no whitespace to chomp
		if not leading_whitespace then
			return
		end
		local line_depth = leading_whitespace:len()
		if global_depth == 0 or line_depth < global_depth then
			global_depth = line_depth
		end
		::continue::
	end
	for index, line in ipairs(line_list) do
		line_list[index] = line:sub(global_depth + 1)
	end
	vim.fn.setreg("+", table.concat(line_list, "\n"))
end, {
	range = true,
	desc = "yank and remove unnecessary leading whitespace",
})

vim.api.nvim_create_user_command("Stab", function()
	local success, choice =
		pcall(vim.fn.confirm, "Which direction?", "&Next\n&previous")
	if not success then
		return
	elseif choice == 1 then
		vim.cmd.tabnext()
	end
	local window = vim.api.nvim_get_current_win()
	local buffer = vim.api.nvim_win_get_buf(window)
	vim.cmd.tabprevious()
	vim.cmd.sbuffer({
		args = { buffer },
		mods = { vertical = true },
	})
	vim.api.nvim_win_close(window, false)
end, {
	desc = "create a split from two tabs",
})
