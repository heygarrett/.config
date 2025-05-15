vim.opt.sessionoptions = { "blank", "help", "tabpages" }

local group = vim.api.nvim_create_augroup("sessions", { clear = true })

vim.api.nvim_create_autocmd("VimEnter", {
	desc = "load or create session on launch",
	group = group,
	nested = true,
	callback = function()
		if vim.env.ENV_EDITOR then
			return
		end
		if vim.v.argv[#vim.v.argv] == "-" then
			return
		end
		if vim.fn.argc() > 0 then
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
			vim.defer_fn(function()
				vim.notify("Loaded session!")
			end, 500)
		else
			vim.cmd.mksession({
				mods = { emsg_silent = true },
			})
			if vim.fn.filereadable("Session.vim") == 1 then
				vim.defer_fn(function()
					vim.notify("Created session!")
				end, 500)
			end
		end
		if #vim.api.nvim_list_bufs() == 1 and vim.api.nvim_buf_get_name(0) == "" then
			vim.cmd.Ex()
		end
	end,
})

vim.api.nvim_create_autocmd("VimLeavePre", {
	desc = "overwrite existing session when exiting",
	group = group,
	callback = function()
		if vim.env.ENV_EDITOR then
			return
		end
		if vim.v.argv[#vim.v.argv] == "-" then
			return
		end
		if vim.fn.filereadable("Session.vim") == 0 then
			return
		end
		-- Save session when a session exists and arg list is empty
		if vim.fn.argc() > 0 then
			-- Ask iff session exists but arg list is not empty
			::require_choice::
			local success, choice = pcall(vim.fn.confirm, "Save session?", "&yes\n&No", 2)
			if not success then
				goto require_choice
			elseif choice == 2 then
				-- Exit early if we don't want to save a session
				return
			end
		end
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
		vim.cmd.mksession({ bang = true })
	end,
})
