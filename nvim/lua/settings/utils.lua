-- Sort lines by length
vim.api.nvim_create_user_command("Sort", function(t)
	local line_list = {}
	for n = t.line1, t.line2 do
		line_list[#line_list + 1] = vim.fn.getline(n)
	end
	table.sort(line_list, function(a, b)
		if t.bang then
			return a:len() > b:len()
		else
			return a:len() < b:len()
		end
	end)
	vim.fn.setline(t.line1, line_list)
end, { range = "%", bang = true })

local M = {}

-- Check nvim's parent process
M.launched_by_user = function()
	local parent_process = vim.fn.system(
		string.format(
			"ps -o ppid= -p %s | xargs ps -o comm= -p | tr -d '\n'",
			vim.fn.getpid()
		)
	)
	return parent_process == "-fish"
end

return M
