local utils = require("settings.utils")

local function get_branch_name()
	local branch = vim.fn.system("git branch --show-current 2> /dev/null")
	if branch ~= "" and utils.launched_by_user() then
		return branch:gsub("\n", "")
	else
		return nil
	end
end

local function get_file_name()
	local user = vim.fn.system("echo $USER"):gsub("\n", "")
	local root_path = vim.fn.getcwd()
	local root_dir = root_path:match("[^/]+$")
	local home_path = vim.fn.expand("%:~")
	local overlap, _ = home_path:find(root_dir)
	if home_path == "" then
		return root_path:gsub("/Users/" .. user, "~")
	elseif overlap then
		return home_path:sub(overlap)
	else
		return home_path
	end
end

local function get_modified_flag()
	if not vim.opt.modifiable:get() then
		return "[-]"
	elseif vim.opt.modified:get() then
		return "[+]"
	else
		return nil
	end
end

local function get_search_count()
	if vim.v.hlsearch == 1 and vim.fn.mode():match("n") then
		local search_count = vim.fn.searchcount({ maxcount = 0 })
		return ("[%d/%d]"):format(search_count["current"], search_count["total"])
	else
		return nil
	end
end

local function get_diagnostics()
	local diagnostics = vim.diagnostic.get(0)
	if #diagnostics == 0 or vim.fn.mode():match("^i") then return nil end

	local severities = { ERROR = 0, WARN = 0, HINT = 0, INFO = 0 }
	for _, v in ipairs(diagnostics) do
		for k, _ in pairs(severities) do
			if v["severity"] == vim.diagnostic.severity[k] then
				severities[k] = severities[k] + 1
			end
		end
	end

	local output = {}
	if severities["ERROR"] > 0 then
		table.insert(
			output,
			("%s%d%s"):format("%#DiagnosticError#", severities["ERROR"], "%*")
		)
	end
	if severities["WARN"] > 0 then
		table.insert(
			output,
			("%s%d%s"):format("%#DiagnosticWarn#", severities["WARN"], "%*")
		)
	end
	if severities["HINT"] > 0 then
		table.insert(
			output,
			("%s%d%s"):format("%#DiagnosticHint#", severities["HINT"], "%*")
		)
	end
	if severities["INFO"] > 0 then
		table.insert(
			output,
			("%s%d%s"):format("%#DiagnosticInfo#", severities["INFO"], "%*")
		)
	end

	return ("[%s]"):format(table.concat(output, " "))
end

local function get_file_type()
	local filetype = vim.opt.filetype:get()
	if filetype ~= "" then filetype = string.format("[%s]", filetype) end
	return filetype
end

local function get_progress()
	if vim.fn.line(".") == 1 then
		return "[top]"
	elseif vim.fn.line(".") == vim.fn.line("$") then
		return "[bot]"
	else
		local p = vim.fn.line(".") / vim.fn.line("$") * 100
		p = p % 1 >= 0.5 and math.ceil(p) or math.floor(p)
		return ("[%02d%s]"):format(p, "%%")
	end
end

vim.api.nvim_create_autocmd({ "FileType", "BufEnter", "FocusGained" }, {
	group = vim.api.nvim_create_augroup("statusline", { clear = true }),
	callback = function()
		vim.b.branch_name = get_branch_name()
		vim.b.file_name = get_file_name()
		vim.b.file_type = get_file_type()
	end,
})

local function generate_left(branch, file)
	branch = branch or vim.b.branch_name
	file = file or vim.b.file_name

	local left = {}
	if branch then table.insert(left, branch) end
	table.insert(left, file)
	left = { table.concat(left, " | ") }
	local modified_flag = get_modified_flag()
	if modified_flag then table.insert(left, modified_flag) end
	return table.concat(left, " ")
end

local function truncate(overflow)
	local min_width = 15
	local new_branch = vim.b.branch_name
	local new_file = vim.b.file_name

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

	if overflow > 0 and vim.b.file_name:len() > min_width then
		if vim.b.file_name:len() - overflow >= min_width then
			new_file = vim.b.file_name:sub(overflow + 1)
		else
			new_file = vim.b.file_name:sub(vim.b.file_name:len() - min_width + 1)
		end
		new_file = new_file:gsub("^.", "<")
	end

	return new_branch, new_file
end

function Status_Line()
	local left_string = generate_left()

	local right_table = {}
	local diagnostics, search_count = get_diagnostics(), get_search_count()
	if diagnostics then table.insert(right_table, diagnostics) end
	if search_count then
		table.insert(right_table, search_count)
	elseif vim.b.gitsigns_status and vim.b.gitsigns_status ~= "" then
		table.insert(right_table, string.format("[%s]", vim.b.gitsigns_status))
	end
	table.insert(right_table, vim.b.file_type)
	table.insert(right_table, get_progress())
	local right_string = table.concat(right_table, " ")
	local right_string_length =
		right_string:gsub("%%#%a+#", ""):gsub("%%%*", ""):gsub("%%%%", "%"):len()

	local length = left_string:len() + right_string_length + 1
	local overflow = length - vim.fn.winwidth(0)
	local separator = "%="
	if overflow > 0 then
		separator = " "
		local trunc_branch, trunc_file = truncate(overflow)
		left_string = generate_left(trunc_branch, trunc_file)
	end

	return table.concat({ "%<", left_string, separator, right_string })
end

vim.opt.statusline = "%{%v:lua.Status_Line()%}"
