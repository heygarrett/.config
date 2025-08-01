---@return string
local function get_parent_dir()
	local path_to_cwd = vim.fn.fnamemodify(vim.fn.getcwd(0), ":h")
	if path_to_cwd == vim.env.HOME then
		return "~"
	else
		return vim.fn.fnamemodify(path_to_cwd, ":t")
	end
end

---@param cwd string
---@return string
local function format_cwd(cwd)
	return ("(%s)"):format(cwd)
end

-- get name of the current buffer
---@return string
local function get_buffer_name()
	-- get root of cwd
	local root_dir = vim.fn.fnamemodify(vim.fn.getcwd(0), ":t")
	-- strip potential prefix and get file path
	local buf_name = vim.api.nvim_buf_get_name(0):gsub("/$", "")
	local _, split, prefix = buf_name:find("^(.+://)")
	local file_path = split and buf_name:sub(split + 1) or buf_name
	-- format file path
	---@type string
	local formatted_file_path
	local truncated_file_path = vim.fn.fnamemodify(file_path, ":.")
	if vim.startswith(truncated_file_path, "/") then
		if truncated_file_path == vim.uv.cwd() then
			formatted_file_path = vim.fs.joinpath(
				vim.fn.fnamemodify(file_path, ":~:h"),
				format_cwd(root_dir)
			)
		else
			formatted_file_path = vim.fn.fnamemodify(file_path, ":~")
		end
	else
		formatted_file_path =
			vim.fs.joinpath(get_parent_dir(), format_cwd(root_dir), truncated_file_path)
	end
	-- restore potential prefix
	if prefix then
		formatted_file_path = prefix .. formatted_file_path
	end

	return formatted_file_path
end

local group = vim.api.nvim_create_augroup("statusline", { clear = true })
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
	if vim.v.hlsearch == 1 and vim.api.nvim_get_mode().mode:match("n") then
		local search_count = vim.fn.searchcount({ maxcount = 0 })
		return ("%d/%d"):format(search_count.current, search_count.total)
	else
		return nil
	end
end

-- get formatted and highlighted string of diagnostic counts
---@return string?
local function get_diagnostics()
	---@type table<integer, integer>
	local diagnostics = vim.diagnostic.count(0)
	if #diagnostics == 0 or vim.api.nvim_get_mode().mode:match("^i") then
		return nil
	end

	---@type string[]
	local formattedSevCounts = vim.iter(pairs(diagnostics))
		:map(
			---@param severity integer
			---@param count integer
			function(severity, count)
				return table.concat({
					"%#DiagnosticSign",
					({ "Error", "Warn", "Info", "Hint" })[severity],
					"#",
					count,
					"%*",
				})
			end
		)
		:totable()

	return table.concat(formattedSevCounts, " ")
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
	table.insert(right_table, get_diagnostics())
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
