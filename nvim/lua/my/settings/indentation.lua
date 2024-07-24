-- Default to tabs
vim.o.expandtab = false
vim.o.shiftwidth = 0
vim.o.softtabstop = 0
vim.o.tabstop = 4
vim.opt.listchars = { nbsp = "_", space = "·", tab = "| " }

-- don't run editorconfig automatically
vim.g.editorconfig = false

local group = vim.api.nvim_create_augroup("indentation", { clear = true })
vim.api.nvim_create_autocmd("BufWinEnter", {
	desc = "indentation settings",
	group = group,
	callback = function(event_opts)
		-- override expandtab set by ftplugins
		vim.bo.expandtab = vim.go.expandtab

		-- load editorconfig
		if vim.bo[event_opts.buf].filetype ~= "gitcommit" then
			require("editorconfig").config(event_opts.buf)
		end

		-- run guess-indent
		local guess_indent_loaded, guess_indent = pcall(require, "guess-indent")
		if guess_indent_loaded then
			-- defers to editorconfig
			vim.cmd.GuessIndent({ args = { "context", "silent" } })
			-- get indent size from buffer if editorconfig specifies spaces for
			-- indentation but not the size of the indent
			if
				vim.b.editorconfig
				and vim.b.editorconfig.indent_style == "space"
				and not vim.b.editorconfig.indent_size
			then
				local indent = guess_indent.guess_from_buffer()
				if indent ~= "tabs" then
					vim.bo.tabstop = tonumber(indent)
				end
			end
		end

		-- finalize listchars
		vim.cmd.Relist()

		-- define Retab user command
		vim.api.nvim_buf_create_user_command(
			event_opts.buf,
			"Retab",
			function(command_opts)
				-- match indentation to value of expandtab
				local indent = guess_indent.guess_from_buffer()
				if (indent == "tabs") == vim.bo.expandtab then
					-- prompt for retab if formatting manually
					if command_opts.bang then
						local success, choice = pcall(
							vim.fn.confirm,
							"Override formatter indentation?",
							"&Yes\n&no"
						)
						if not success then
							return
						elseif choice == 2 then
							return
						end
					end
					-- then retab
					local preferred_tabstop = (
						vim.bo.expandtab and vim.bo.tabstop or vim.go.tabstop
					)
					if indent ~= "tabs" then
						vim.bo.tabstop = tonumber(indent)
					end
					vim.cmd.retab({ bang = true })
					vim.bo.tabstop = preferred_tabstop
					if vim.bo.expandtab then
						vim.bo.shiftwidth = preferred_tabstop
					else
						vim.bo.shiftwidth = 0
					end
				end
			end,
			{
				bang = true,
				desc = "custom retab",
			}
		)
	end,
})

vim.api.nvim_create_user_command("Relist", function()
	if vim.bo.expandtab then
		-- set whitespace characters for indentation with spaces
		local listchars = vim.opt_global.listchars:get()
		listchars.tab = "> "
		if vim.bo.filetype ~= "markdown" then
			listchars.leadmultispace = ":" .. (" "):rep(vim.bo.shiftwidth - 1)
		end
		vim.opt_local.listchars = listchars
	else
		-- remove leadmultispace from listchars
		vim.wo.listchars = vim.go.listchars
		-- override tabstop if we're using tabs
		vim.bo.tabstop = vim.go.tabstop
		-- reset shiftwidth
		vim.bo.shiftwidth = vim.go.shiftwidth
	end
	-- keep softtabstop turned off
	vim.bo.softtabstop = vim.go.softtabstop
end, { desc = "re-set listchars" })
