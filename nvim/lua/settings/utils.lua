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

-- Option to copy code without leading indents
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("utils", { clear = true }),
	callback = function()
		if vim.v.operator ~= "y" or vim.v.register ~= "+" then
			-- Exit early if we're not yanking to the system clipboard
			return
		end
		local yanked_text = vim.fn.getreg()
		local global_depth = 0
		local line_list = {}
		-- Split on new lines
		for line in yanked_text:gmatch("[^\n]+") do
			local leading_whitespace = line:match("^%s+")
			if not leading_whitespace then
				-- Exit early if any line lacks preceding whitespace
				return
			end
			local line_depth = leading_whitespace:len()
			if global_depth == 0 or line_depth < global_depth then
				global_depth = line_depth
			end
			table.insert(line_list, line)
		end

		local chomp = "n"
		repeat
			vim.ui.input({ prompt = "Chomp indentation? [y/N] " }, function(input)
				if input then
					chomp = input
				end
			end)
		until chomp:match("^[YyNn]$")

		if chomp:match("^[Yy]$") then
			for index, line in ipairs(line_list) do
				line_list[index] = line:sub(global_depth + 1)
			end
			vim.fn.setreg(vim.v.register, table.concat(line_list, "\n"))
		end
	end,
})
