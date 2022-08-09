-- Sort lines by length
vim.api.nvim_create_user_command("Sort", function(t)
	local line_list = {}
	for n = t.line1, t.line2 do
		line_list[#line_list + 1] = vim.fn.getline(n)
	end
	table.sort(line_list, function(a, b) return a:len() < b:len() end)
	vim.fn.setline(t.line1, line_list)
end, { range = true })
