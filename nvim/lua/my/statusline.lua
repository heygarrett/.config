-- get formatted buffer name
---@return string
local function get_buffer_name()
	local buf_name = vim.api.nvim_buf_get_name(0)
	local cwd = vim.uv.cwd()
	if not cwd then
		return buf_name
	end

	local basename = vim.fs.basename(cwd)
	local formatted_basename = ("(%s)"):format(basename)
	local formatted_cwd = cwd:gsub("[^/]+$", formatted_basename)
	local formatted_buf_name = buf_name:gsub(cwd, formatted_cwd):gsub(vim.env.HOME, "~")

	return formatted_buf_name
end

local group = vim.api.nvim_create_augroup("statusline", {
	clear = true,
})
vim.api.nvim_create_autocmd({ "FileType", "BufEnter", "FocusGained" }, {
	desc = "buffer name variable updated",
	group = group,
	callback = function()
		vim.b.buffer_name = get_buffer_name()
	end,
})
vim.api.nvim_create_autocmd({ "CursorHold", "DiagnosticChanged", "TextChanged" }, {
	desc = "refresh statusline",
	group = group,
	callback = function()
		vim.cmd.redrawstatus()
	end,
})

-- get instance and count of search matches
---@return string?
local function get_search_count()
	if not (vim.v.hlsearch == 1 and vim.api.nvim_get_mode().mode:match("n")) then
		return nil
	end

	local search_count = vim.fn.searchcount({
		maxcount = 0,
	})
	if not (search_count.current and search_count.total) then
		return nil
	end

	return ("%d/%d"):format(search_count.current, search_count.total)
end

-- get location in current buffer as a percentage
---@return string
local function get_progress()
	local p = vim.api.nvim_eval_statusline("%p", {}).str
	if p == "0" or vim.fn.line(".") == 1 then
		return "top"
	elseif p == "100" then
		return "bot"
	else
		---@type string
		local result
		local ok, pnum = pcall(tonumber, p)
		if ok and pnum then
			result = ("%02d"):format(pnum)
		else
			result = "--"
		end
		return result .. "%%"
	end
end

-- format string for left side of statusline
---@param buffer string?
---@return string
local function generate_left(buffer)
	buffer = buffer or vim.b.buffer_name

	local left = {}
	if buffer ~= "" then
		table.insert(left, buffer)
	end

	if not vim.o.endofline then
		table.insert(left, "[noeol]")
	end
	local modified_flag = vim.api.nvim_eval_statusline("%m", {}).str
	if modified_flag ~= "" then
		table.insert(left, modified_flag)
	end

	return table.concat(left, " ")
end

-- format string for right side of status line
---@return string
local function generate_right()
	local right_table = {}
	local search_count = get_search_count()
	if search_count then
		table.insert(right_table, search_count)
	end
	local diagnostic_status = vim.diagnostic.status()
	if diagnostic_status ~= "" then
		table.insert(right_table, diagnostic_status)
	end
	local file_type = vim.api.nvim_eval_statusline("%Y", {}).str:lower()
	if file_type ~= "" then
		table.insert(right_table, file_type)
	end
	table.insert(right_table, get_progress())

	return table.concat(right_table, " | ")
end

-- generate statusline
---@return string
function Status_Line()
	local left_string = generate_left()
	local left_string_length =
		vim.api.nvim_eval_statusline(left_string, { maxwidth = 0 }).width

	local right_string = generate_right()
	local right_string_length = vim.api.nvim_eval_statusline(right_string, {}).width

	local divider = " | "
	local length = left_string_length + #divider + right_string_length
	local overflow = length - vim.api.nvim_win_get_width(0)
	if overflow < 0 then
		divider = "%="
	end

	return table.concat({ "%<", left_string, divider, right_string })
end

vim.o.statusline = "%{%v:lua.Status_Line()%}"
