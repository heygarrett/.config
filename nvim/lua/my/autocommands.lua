local group = vim.api.nvim_create_augroup("autocommands", {
	clear = true,
})

vim.api.nvim_create_autocmd("BufRead", {
	desc = "restore cursor position",
	group = group,
	callback = function(event_opts)
		vim.api.nvim_create_autocmd("FileType", {
			group = group,
			buf = event_opts.buf,
			once = true,
			callback = function()
				local exclude = { "diff" }
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
			mods = {
				emsg_silent = true,
			},
		})
	end,
})

vim.api.nvim_create_autocmd("VimResized", {
	desc = "resize splits when vim is resized",
	group = group,
	callback = function()
		vim.cmd.normal({
			args = { vim.keycode("<c-w>") .. "=" },
		})
	end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
	desc = "force commentstring to include spaces",
	group = group,
	callback = function(event_opts)
		local commentstring = vim.bo[event_opts.buf].commentstring
		vim.bo[event_opts.buf].commentstring =
			commentstring:gsub("(%S)%%s", "%1 %%s"):gsub("%%s(%S)", "%%s %1")
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	desc = "add barrier to saving commit message if diagnostics are present",
	group = group,
	pattern = "jjdescription",
	callback = function(filetype_event_opts)
		vim.api.nvim_create_autocmd("ExitPre", {
			desc = "add barrier to saving commit message if diagnostics are present",
			group = group,
			buf = filetype_event_opts.buf,
			callback = function(exit_event_opts)
				local diagnostics = vim.diagnostic.count(exit_event_opts.buf)
				if not vim.tbl_isempty(diagnostics) then
					-- HACK: https://github.com/neovim/neovim/issues/17256
					vim.bo[exit_event_opts.buf].modified = true
				end
			end,
		})
	end,
})
