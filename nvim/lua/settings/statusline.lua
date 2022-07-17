local function branch_name()
	local branch = vim.fn.system("git branch --show-current 2> /dev/null")
	if branch ~= "" then
		return branch:gsub("\n", "") .. " |"
	else
		return ""
	end
end

local function diagnostics()
	local diags = ""
	if #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR }) ~= 0 then
		diags = diags .. "🔴"
	end
	if #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN }) ~= 0 then
		diags = diags .. "🟡"
	end
	if #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT }) ~= 0 then
		diags = diags .. "🔵"
	end
	if #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO }) ~= 0 then
		diags = diags .. "⚪"
	end
	return not vim.fn.mode():match("^i") and diags or ""
end

local function file_name()
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

local function progress()
	if vim.fn.line(".") == 1 then
		return "top"
	elseif vim.fn.line(".") == vim.fn.line("$") then
		return "bot"
	else
		local p = vim.fn.line(".") / vim.fn.line("$") * 100
		p = p % 1 >= .5 and math.ceil(p) or math.floor(p)
		return string.format("%02d", p) .. "%%"
	end
end

vim.api.nvim_create_augroup("statusline", { clear = true })
vim.api.nvim_create_autocmd({ "FileType", "BufEnter", "FocusGained" }, {
	group = "statusline",
	callback = function()
		vim.b.branch_name = branch_name()
		vim.b.file_name = file_name()
	end
})

function Status_Line()
	local status = " "
		.. "%<"
		.. vim.b.branch_name
		.. " "
		.. diagnostics()
		.. " "
		.. vim.b.file_name
		.. " "
		.. "%h"
		.. "%m"
		.. "%="
		.. "%y"
		.. " "
		.. progress()
		.. " "
	return status:gsub("%s%s+", " ")
end

vim.opt.statusline = "%{%v:lua.Status_Line()%}"
