vim.opt.sessionoptions = { "blank", "help", "tabpages" }

vim.api.nvim_create_augroup("sessions", { clear = true })

vim.api.nvim_create_autocmd("VimEnter", {
	desc = "load or create session on launch",
	group = "sessions",
	nested = true,
	callback = function()
		if vim.fn.argc() > 0 then
			return
		end
		if vim.g.launched_by_shell then
			return
		end
		if vim.fn.filereadable("Session.vim") == 1 then
			vim.cmd.source({
				args = { "Session.vim" },
				mods = {
					silent = false,
					emsg_silent = true,
				},
			})
			---@diagnostic disable-next-line: param-type-mismatch
			vim.defer_fn(function() vim.notify("Loaded session!") end, 500)
		else
			vim.cmd.mksession({
				mods = {
					emsg_silent = true,
				},
			})
			if vim.fn.filereadable("Session.vim") == 1 then
				---@diagnostic disable-next-line: param-type-mismatch
				vim.defer_fn(function() vim.notify("Created session!") end, 500)
			end
		end
		if #vim.api.nvim_list_bufs() == 1 and vim.api.nvim_buf_get_name(0) == "" then
			vim.cmd.Oil()
		end
	end,
})

vim.api.nvim_create_autocmd("VimLeavePre", {
	desc = "overwrite existing session when exiting",
	group = "sessions",
	callback = function()
		if vim.g.launched_by_shell then
			return
		end
		if vim.fn.filereadable("Session.vim") == 0 then
			return
		end
		if vim.bo.filetype:match("git") then
			return
		end
		-- Save session when a session exists and arg list is empty
		local save = "y"
		if vim.fn.argc() > 0 then
			-- Ask iff session exists but arg list is not empty
			repeat
				vim.ui.input({ prompt = "Save session? [y/N] " }, function(input)
					if input ~= "" then
						save = input
					else
						save = "n"
					end
				end)
			until save:match("^[YyNn]$")
		end
		if save:match("^[Yy]$") then
			-- Prevent arg list from getting saved in session
			vim.cmd.argdelete({
				range = { 0, vim.fn.argc() },
			})
			-- Prevent terminal buffers from getting saved in session
			vim.cmd.bdelete({
				bang = true,
				args = { "term://*" },
				mods = { emsg_silent = true },
			})
			-- Save session
			vim.cmd.mksession({
				bang = true,
			})
		end
	end,
})
