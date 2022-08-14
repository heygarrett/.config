local utils = require("settings.utils")

local function get_branch_name()
	local branch = vim.fn.system("git branch --show-current 2> /dev/null")
	if branch ~= "" and utils.launched_by_user() then
		return branch:gsub("\n", "") .. " |"
	else
		return ""
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
		return ""
	end
end

local function get_diagnostics()
	if #vim.diagnostic.get(0) == 0 or vim.fn.mode():match("^i") then
		return ""
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

function Status_Line()
	local diagnostics = get_diagnostics()
	local left = table.concat({
		vim.b.branch_name,
		vim.b.file_name,
		get_modified_flag(),
	}, " ")

	local right = table.concat({
		diagnostics,
		vim.b.gitsigns_status or "",
		vim.b.file_type,
		get_progress(),
	}, " ")

	local length = left:len() + right:len()
	local gap = vim.fn.winwidth(0) - length
	if diagnostics ~= "" then gap = gap + 2 end
	if right:sub(-1) == "%" then gap = gap + 1 end
	if gap < 1 then gap = 1 end

	return table.concat({ left, string.rep(" ", gap), right })
end

vim.opt.statusline = "%{%v:lua.Status_Line()%}"
