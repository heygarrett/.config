local group = vim.api.nvim_create_augroup("lsp", { clear = true })
vim.api.nvim_create_autocmd("LspAttach", {
	desc = "LSP options, commands and keymaps",
	group = group,
	callback = function(event_opts)
		local client = assert(
			vim.lsp.get_client_by_id(event_opts.data.client_id),
			"Client ID invalid"
		)

		-- Enable LSP completion
		if client:supports_method("textDocument/completion", event_opts.buf) then
			vim.lsp.completion.enable(true, client.id, event_opts.buf)
		end

		-- Enable inlay hints
		vim.lsp.inlay_hint.enable(true, { bufnr = event_opts.buf })
		vim.api.nvim_buf_create_user_command(event_opts.buf, "ToggleHints", function()
			vim.lsp.inlay_hint.enable(
				not vim.lsp.inlay_hint.is_enabled({ bufnr = event_opts.buf }),
				{ bufnr = event_opts.buf }
			)
		end, { desc = "toggle inlay hints" })

		-- Other LSP keymaps and user commands
		vim.api.nvim_buf_create_user_command(
			event_opts.buf,
			"Rename",
			function(command_opts)
				if command_opts.args ~= "" then
					vim.lsp.buf.rename(command_opts.args)
				else
					vim.api.nvim_input(
						("q:aRename %s<esc>"):format(vim.fn.expand("<cword>"))
					)
				end
			end,
			{
				nargs = "?",
				desc = "rename references to symbol under the cursor",
			}
		)
	end,
})
