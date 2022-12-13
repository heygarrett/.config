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

local M = {}

-- Check nvim's parent process
M.launched_by_user = function()
	-- If the parent process is not fish then nvim was not launched by the user
	local fish_parent = vim.fn.system(
		string.format(
			"ps -o ppid= -p %s | xargs ps -o comm= -p | tr -d '\n'",
			vim.fn.getpid()
		)
	) == "-fish"
	-- If there's only one buffer and it's not in the cwd
	-- then nvim was prorably not launched by the user
	-- This is for fish binding Option-V
	local multiple_buffers = #vim.api.nvim_list_bufs() > 1
	local file_path = vim.fn.expand("%:p")
	local file_in_cwd = vim.startswith(file_path, vim.fn.getcwd()) or file_path == ""

	return fish_parent and (multiple_buffers or file_in_cwd)
end

return M
