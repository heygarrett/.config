vim.api.nvim_create_user_command("Update", function()
	local group = vim.api.nvim_create_augroup("update", { clear = true })
	vim.api.nvim_create_autocmd("User", {
		pattern = "VeryLazy",
		desc = "run Lazy sync",
		group = group,
		once = true,
		callback = function()
			vim.cmd.Lazy({
				args = { "sync" },
			})
		end,
	})
	local ok, _ = pcall(require, "mason")
	if ok then
		vim.cmd.MasonUpdate()
	end
	ok, _ = pcall(require, "mason-tool-installer")
	if ok then
		vim.cmd.MasonToolsUpdate()
	end
end, { desc = "update plugins and packages" })

vim.api.nvim_create_user_command("Sort", function(command_opts)
	local line_list =
		vim.api.nvim_buf_get_lines(0, command_opts.line1 - 1, command_opts.line2, true)
	table.sort(line_list, function(a, b)
		local a_len = vim.fn.strdisplaywidth(a)
		local b_len = vim.fn.strdisplaywidth(b)
		if a_len == b_len then
			return a < b
		elseif command_opts.bang then
			return a_len > b_len
		else
			return a_len < b_len
		end
	end)
	vim.api.nvim_buf_set_lines(
		0,
		command_opts.line1 - 1,
		command_opts.line2,
		true,
		line_list
	)
end, {
	range = "%",
	bang = true,
	desc = "sort lines by length",
})

vim.api.nvim_create_user_command("Gobble", function(command_opts)
	local line_list =
		vim.api.nvim_buf_get_lines(0, command_opts.line1 - 1, command_opts.line2, true)
	local global_depth = 0
	for _, line in ipairs(line_list) do
		if #line == 0 then
			goto continue
		end
		local leading_whitespace = line:match("^%s+")
		-- skip gobbling if there's no whitespace to gobble
		if not leading_whitespace then
			goto skip
		end
		local line_depth = leading_whitespace:len()
		if global_depth == 0 or line_depth < global_depth then
			global_depth = line_depth
		end
		::continue::
	end
	for index, line in ipairs(line_list) do
		line_list[index] = line:sub(global_depth + 1)
	end
	::skip::
	vim.fn.setreg("+", table.concat(line_list, "\n"))
end, {
	range = true,
	desc = "yank and remove unnecessary leading whitespace",
})

vim.api.nvim_create_user_command("Stab", function()
	local success, choice = pcall(vim.fn.confirm, "Which direction?", "&Next\n&previous")
	if not success then
		return
	elseif choice == 1 then
		vim.cmd.tabnext()
	end
	local window = vim.api.nvim_get_current_win()
	local buffer = vim.api.nvim_win_get_buf(window)
	vim.cmd.tabprevious()
	vim.cmd.sbuffer({
		args = { buffer },
		mods = { vertical = true },
	})
	vim.api.nvim_win_close(window, false)
end, { desc = "create a split from two tabs" })

vim.api.nvim_create_user_command("CopyFileName", function()
	local name = vim.api.nvim_buf_get_name(0)
	name = vim.fn.fnamemodify(name, ":.")
	vim.fn.setreg("+", name)
	vim.notify_once("File name copied to clipboard!")
end, { desc = "copy file name to clipboard" })

vim.api.nvim_create_user_command("JJdiff", function()
	local left_contents = vim.api.nvim_buf_get_lines(0, 0, -1, true)
	-- close $left
	vim.cmd.diffoff()
	vim.cmd.close()
	-- put contents of $left into $output
	vim.api.nvim_buf_set_lines(0, 0, -1, true, left_contents)
end, { desc = "jj diff setup" })

vim.api.nvim_create_user_command("Diagnostics", function()
	vim.diagnostic.setloclist()
end, { desc = "add buffer diagonstics to location list" })
