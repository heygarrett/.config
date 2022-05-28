vim.api.nvim_create_autocmd({"BufEnter", "CursorHold", "FocusGained"}, {
	callback = function()
		-- Branch name
		local branch = vim.fn.system("git branch --show-current | tr -d '\n' 2> /dev/null")
		if branch then
			vim.b.branch_name = branch .. " | "
		else
			vim.b.branch_name = ""
		end

		-- File name
		local root_path = vim.fn.getcwd()
		local root_dir = root_path:match("[^/]+$")
		local home_path = vim.fn.expand("%:~")
		local overlap, _ = home_path:find(root_dir)
		if home_path == "" then
			vim.b.file_name = root_path:gsub("/Users/garrett", "~")
		elseif overlap then
			vim.b.file_name = home_path:sub(overlap)
		else
			vim.b.file_name = home_path
		end
	end
})

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
		.. (vim.b.branch_name or "")
		.. (vim.b.file_name or "")
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
