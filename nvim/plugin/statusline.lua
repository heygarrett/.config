local function branch_name()
	local branch = io.popen("git rev-parse --abbrev-ref HEAD 2> /dev/null")
	if branch then
		local name = branch:read("*l")
		branch:close()
		if name then
			return name .. " | "
		else
			return ""
		end
	end
end

local function file_name()
	local root_path = vim.fn.getcwd()
	local root_dir = root_path:match("[^/]+$")
	local home_path = vim.fn.expand("%:~")
	local overlap, _ = home_path:find(root_dir)
	if home_path == "" then
		return root_path:gsub("/Users/garrett", "~")
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

function _G.status_line()
	return " "
		.. "%<"
		.. branch_name()
		.. file_name()
		.. " "
		.. "%h"
		.. "%m"
		.. "%="
		.. "%y"
		.. " "
		.. progress()
		.. " "
end

vim.opt.statusline = "%{%v:lua.status_line()%}"
