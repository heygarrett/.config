---Get the name of the current branch
---@return string?
local function get_branch_name()
	if vim.g.launched_by_shell then
		return nil
	end
	local branch_cmd = vim.system({ "git", "branch", "--show-current" }):wait()
	if branch_cmd.stdout == "" or branch_cmd.code ~= 0 then
		return nil
	end

	local branch_name, _ = branch_cmd.stdout:gsub("\n", "")
	return branch_name
end

---@return string
local function get_parent_dir()
	local path_to_cwd = vim.fn.fnamemodify(vim.fn.getcwd(0), ":h")
	if path_to_cwd == vim.env.HOME then
		return "~"
	else
		return vim.fn.fnamemodify(path_to_cwd, ":t")
	end
end

---Get name of the current buffer
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
	if
		vim.startswith(truncated_file_path, "/")
		or truncated_file_path == ""
	then
		formatted_file_path = vim.fn.fnamemodify(file_path, ":~")
	else
		formatted_file_path = vim.fs.joinpath(
			get_parent_dir(),
			("(%s)"):format(root_dir),
			truncated_file_path
		)
	end
	-- restore potential prefix
	if prefix then
		formatted_file_path = prefix .. formatted_file_path
	end

	return formatted_file_path
end

local group = vim.api.nvim_create_augroup("statusline", { clear = true })
vim.api.nvim_create_autocmd({ "FileType", "BufEnter", "FocusGained" }, {
	desc = "keep branch and buffer name variables updated",
	group = group,
	callback = function()
		vim.b.branch_name = get_branch_name()
		vim.b.buffer_name = get_buffer_name()
	end,
})
vim.api.nvim_create_autocmd({ "CursorHold", "TextChanged" }, {
	desc = "refresh statusline",
	group = group,
	callback = function() vim.cmd.redraws() end,
})

---Get instance and count of search matches
---@return string?
local function get_search_count()
	if vim.v.hlsearch == 1 and vim.api.nvim_get_mode().mode:match("n") then
		local search_count = vim.fn.searchcount({ maxcount = 0 })
		return ("%d/%d"):format(search_count.current, search_count.total)
	else
		return nil
	end
end

---Get formatted and highlighted string of diagnostic counts
---@return string?
local function get_diagnostics()
	local diagnostics = vim.diagnostic.get(0)
	if #diagnostics == 0 or vim.api.nvim_get_mode().mode:match("^i") then
		return nil
	end

	local severities = {
		ERROR = { match = "Error", count = 0 },
		WARN = { match = "Warn", count = 0 },
		HINT = { match = "Hint", count = 0 },
		INFO = { match = "Info", count = 0 },
	}

	for _, v in ipairs(diagnostics) do
		for k, _ in pairs(severities) do
			if v.severity == vim.diagnostic.severity[k] then
				severities[k].count = severities[k].count + 1
			end
		end
	end

	local output = {}
	for _, v in pairs(severities) do
		if v.count > 0 then
			table.insert(
				output,
				table.concat({
					"%#DiagnosticVirtualText",
					v.match,
					"#",
					v.count,
					"%*",
				})
			)
		end
	end

	table.sort(output, function(a, b)
		local sort_order = { Error = 1, Warn = 2, Hint = 3, Info = 4 }
		local a_sev = a:match("(%u%l+)#")
		local b_sev = b:match("(%u%l+)#")

		return sort_order[a_sev] < sort_order[b_sev]
	end)

	return table.concat(output, " ")
end

---Get location in current buffer as a percentage
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
		local pnum = tonumber(p)
		if pnum then
			result = ("%02d"):format(pnum)
		else
			result = "--"
		end
		return result .. "%%"
	end
end

---Format string for left side of statusline
---@param branch string?
---@param buffer string?
---@return string
local function generate_left(branch, buffer)
	branch = branch or vim.b.branch_name
	buffer = buffer or vim.b.buffer_name

	local left = {}
	if branch then
		table.insert(left, branch)
	end
	if buffer ~= "" then
		table.insert(left, buffer)
	end
	left = { table.concat(left, " | ") }

	if not vim.o.endofline then
		table.insert(left, "[noeol]")
	end
	local modified_flag = vim.api.nvim_eval_statusline("%m", {}).str
	if modified_flag ~= "" then
		table.insert(left, modified_flag)
	end

	return table.concat(left, " ")
end

---Truncate branch and buffer names for narrow window
---@param overflow number
---@return string?
---@return string
local function truncate(overflow)
	local min_width = 15
	local new_branch = vim.b.branch_name
	local new_buffer = vim.b.buffer_name

	if vim.b.branch_name and vim.b.branch_name:len() > min_width then
		if vim.b.branch_name:len() - overflow >= min_width then
			new_branch = vim.b.branch_name:sub(1, (overflow + 1) * -1)
			overflow = 0
		else
			new_branch = vim.b.branch_name:sub(1, min_width)
			overflow = overflow - vim.b.branch_name:sub(min_width + 1):len()
		end
		new_branch = new_branch:gsub(".$", ">")
	end

	if overflow > 0 and vim.b.buffer_name:len() > min_width then
		if vim.b.buffer_name:len() - overflow >= min_width then
			new_buffer = vim.b.buffer_name:sub(overflow + 1)
		else
			new_buffer =
				vim.b.buffer_name:sub(vim.b.buffer_name:len() - min_width + 1)
		end
		new_buffer = new_buffer:gsub("^.", "<")
	end

	return new_branch, new_buffer
end

---Generate statusline
---@return string
function Status_Line()
	local left_string = generate_left()
	local left_string_length =
		vim.api.nvim_eval_statusline(left_string, { maxwidth = 0 }).width

	local right_table = {}
	local search_count = get_search_count()
	if search_count then
		table.insert(right_table, search_count)
	end
	table.insert(right_table, get_diagnostics())
	if vim.b.gitsigns_status ~= "" then
		table.insert(right_table, vim.b.gitsigns_status)
	end
	local file_type = vim.api.nvim_eval_statusline("%Y", {}).str:lower()
	if file_type ~= "" then
		table.insert(right_table, file_type)
	end
	table.insert(right_table, get_progress())
	local right_string = table.concat(right_table, " | ")
	local right_string_length =
		vim.api.nvim_eval_statusline(right_string, {}).width

	local divider = " | "
	local length = left_string_length + divider:len() + right_string_length
	local overflow = length - vim.api.nvim_win_get_width(0)
	if overflow < 0 then
		divider = "%="
	end
	if overflow > 0 then
		local trunc_branch, trunc_buffer = truncate(overflow)
		left_string = generate_left(trunc_branch, trunc_buffer)
	end

	return table.concat({ "%<", left_string, divider, right_string })
end

vim.o.statusline = "%{%v:lua.Status_Line()%}"
