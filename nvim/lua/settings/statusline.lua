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

local function get_diagnostics()
	if #vim.diagnostic.get(0) == 0 or vim.fn.mode():match("^i") then
		return nil
	elseif #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR }) > 0 then
		return "🔴"
	elseif #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN }) > 0 then
		return "🟡"
	elseif #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT }) > 0 then
		return "🔵"
	elseif #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO }) > 0 then
		return "⚪"
	end
end

local function get_file_type()
	local ft = vim.opt.filetype:get()
	if ft ~= "" then ft = table.concat({ "[", ft, "]" }) end
	return ft
end

local function get_progress()
	if vim.fn.line(".") == 1 then
		return "top"
	elseif vim.fn.line(".") == vim.fn.line("$") then
		return "bot"
	else
		local p = vim.fn.line(".") / vim.fn.line("$") * 100
		p = p % 1 >= 0.5 and math.ceil(p) or math.floor(p)
		return string.format("%02d", p) .. "%%"
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
			new_branch = string.sub(vim.b.branch_name, 1, overflow * -1 - 1) .. ">"
			overflow = 0
		else
			new_branch = string.sub(vim.b.branch_name, 1, min_width - 1) .. ">"
			overflow = overflow - string.sub(vim.b.branch_name, min_width):len()
		end
	end

	if overflow > 0 and vim.b.file_name:len() > min_width then
		if vim.b.file_name:len() - overflow >= min_width then
			new_file = "<" .. string.sub(vim.b.file_name, overflow + 2)
		else
			new_file = "<"
				.. string.sub(vim.b.file_name, vim.b.file_name:len() - min_width + 2)
		end
	end

	return new_branch, new_file
end

function Status_Line()
	local left_string = generate_left()

	local right_table = {}
	local diagnostics = get_diagnostics()
	if diagnostics then table.insert(right_table, diagnostics) end
	if vim.b.gitsigns_status and vim.b.gitsigns_status ~= "" then
		table.insert(right_table, string.format("[%s]", vim.b.gitsigns_status))
	end
	table.insert(right_table, vim.b.file_type)
	table.insert(right_table, get_progress())
	local right_string = table.concat(right_table, " ")

	local length = left_string:len() + right_string:len() + 1
	if diagnostics then length = length - 1 end
	if right_string:sub(-1) == "%" then length = length - 1 end
	local overflow = length - vim.fn.winwidth(0)
	if overflow > 0 then
		local trunc_branch, trunc_file = truncate(overflow)
		left_string = generate_left(trunc_branch, trunc_file)
	end

	return table.concat({ "%<", left_string, "%=", right_string })
end

vim.opt.statusline = "%{%v:lua.Status_Line()%}"
