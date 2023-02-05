-- Sort lines by length
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
end, { range = "%", bang = true })

-- Copy code without leading indents
vim.api.nvim_create_user_command("Chomp", function(tbl)
	local line_list = vim.api.nvim_buf_get_lines(0, tbl.line1 - 1, tbl.line2, true)
	local global_depth = 0
	for _, line in ipairs(line_list) do
		local line_depth = (line:match("^%s+") or ""):len()
		if global_depth == 0 or line_depth < global_depth then
			global_depth = line_depth
		end
	end
	for index, line in ipairs(line_list) do
		line_list[index] = line:sub(global_depth + 1)
	end
	vim.fn.setreg("+", table.concat(line_list, "\n"))
end, { range = true })
