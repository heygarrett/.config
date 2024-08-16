local group = vim.api.nvim_create_augroup("options", { clear = true })

vim.api.nvim_create_autocmd("BufRead", {
	desc = "restore cursor position",
	group = group,
	callback = function(event_opts)
		vim.api.nvim_create_autocmd("FileType", {
			group = group,
			buffer = event_opts.buf,
			once = true,
			callback = function()
				local exclude = { "diff", "gitcommit", "gitrebase" }
				if vim.tbl_contains(exclude, vim.bo.filetype) then
					return
				end
				local position_line = vim.api.nvim_buf_get_mark(0, [["]])[1]
				if
					position_line >= 1
					and position_line <= vim.api.nvim_buf_line_count(0)
				then
					vim.cmd.normal({
						bang = true,
						args = { [[g`"]] },
					})
				end
			end,
		})
	end,
})

vim.api.nvim_create_autocmd("CursorHold", {
	desc = "check if any buffers were changed outside of nvim on cursor hold",
	group = group,
	callback = function()
		vim.cmd.checktime({
			mods = { emsg_silent = true },
		})
	end,
})

vim.api.nvim_create_autocmd("VimResized", {
	desc = "resize splits when vim is resized",
	group = group,
	callback = function()
		if vim.api.nvim_get_mode().mode ~= "n" then
			vim.api.nvim_input([[<c-\><c-n>]])
		end
		vim.api.nvim_input("<c-w>=")
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	desc = "disable text width, and wrap, for specific file types",
	group = group,
	pattern = { "markdown", "text" },
	callback = function()
		vim.bo.textwidth = 0
	end,
})

vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "TextChangedP" }, {
	desc = "dynamic color column",
	group = group,
	callback = function()
		if vim.bo.buftype ~= "" then
			return
		end
		local current_line = vim.api.nvim_get_current_line()
		-- `current_line` might be a blob instead of a string (eg, expanding snippets)
		local measured, line_length = pcall(vim.fn.strdisplaywidth, current_line)
		if not measured then
			return
		end
		if line_length >= vim.bo.textwidth - 5 then
			vim.wo.colorcolumn = "+1"
		elseif vim.wo.colorcolumn ~= "" then
			vim.wo.colorcolumn = ""
		end
	end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
	desc = "force commentstring to include spaces",
	group = group,
	callback = function(event_opts)
		local cs = vim.bo[event_opts.buf].commentstring
		vim.bo[event_opts.buf].commentstring = cs:gsub("(%S)%%s", "%1 %%s")
			:gsub("%%s(%S)", "%%s %1")
	end,
})
