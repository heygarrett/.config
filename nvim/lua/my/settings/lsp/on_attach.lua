local group = vim.api.nvim_create_augroup("lsp", { clear = true })
vim.api.nvim_create_autocmd("LspAttach", {
	desc = "LSP options, commands and keymaps",
	group = group,
	callback = function(event_opts)
		local bufnr = event_opts.buf
		local client = vim.lsp.get_client_by_id(event_opts.data.client_id)
		if not client then
			vim.notify_once("Client ID invalid", vim.log.levels.ERROR)
			return
		end

		-- Use omnicomplete with LSP
		require("my.settings.lsp.completion").setup(bufnr, client)

		-- Set border of floating window preview
		vim.lsp.handlers["textDocument/hover"] =
			vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })
		vim.lsp.handlers["textDocument/signatureHelp"] =
			vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" })

		-- Enable inlay hints
		vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
		vim.api.nvim_buf_create_user_command(bufnr, "ToggleHints", function()
			vim.lsp.inlay_hint.enable(
				not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }),
				{ bufnr = bufnr }
			)
		end, { desc = "toggle inlay hints" })

		-- Other LSP keymaps and user commands
		vim.keymap.set("i", "<c-s>", vim.lsp.buf.signature_help, {
			buffer = bufnr,
			desc = "signature help",
		})
		vim.api.nvim_buf_create_user_command(bufnr, "Rename", function(command_opts)
			if command_opts.args ~= "" then
				vim.lsp.buf.rename(command_opts.args)
			else
				vim.api.nvim_input(("q:aRename %s<esc>"):format(vim.fn.expand("<cword>")))
			end
		end, {
			nargs = "?",
			desc = "rename references to symbol under the cursor",
		})
	end,
})
