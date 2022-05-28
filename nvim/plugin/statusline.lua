local function branch_name()
	local branch = vim.fn.system("git branch --show-current | tr -d '\n' 2> /dev/null")
	if branch then
		return branch .. " | "
	else
		return ""
	end
end

local function file_name()
	local root_path = vim.fn.getcwd()
	local root_dir = root_path:match("[^/]+$")
	local home_path = vim.fn.expand("%:~")
	local overlap, _ = home_path:find(root_dir)
	if home_path == "" then
		return root_path:gsub("/Users/[^/]+", "~")
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

vim.api.nvim_create_autocmd({"VimEnter", "BufEnter", "FocusGained"}, {
	callback = function()
		vim.b.branch_name = branch_name()
		vim.b.file_name = file_name()
	end
})

function Status_Line()
	return " "
		.. "%<"
		.. vim.b.branch_name
		.. vim.b.file_name
		.. " "
		.. "%h"
		.. "%m"
		.. "%="
		.. "%y"
		.. " "
		.. progress()
		.. " "
end

vim.opt.statusline = "%{%v:lua.Status_Line()%}"
