local group = vim.api.nvim_create_augroup("lsp", { clear = true })
vim.api.nvim_create_autocmd("LspAttach", {
	desc = "LSP options, commands and keymaps",
	group = group,
	callback = function(args)
		local bufnr = args.buf
		local client = vim.lsp.get_client_by_id(args.data.client_id)

		-- Diagnostics options
		require("my.settings.lsp.diagnostics")
		-- Use omnicomplete with LSP
		require("my.settings.lsp.completion").setup(bufnr, client)

		-- Set border of floating window preview
		local orig_util_open_floating_preview =
			vim.lsp.util.open_floating_preview
		---@diagnostic disable-next-line: duplicate-set-field
		function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
			opts.border = "single"
			return orig_util_open_floating_preview(contents, syntax, opts, ...)
		end

		-- Enable inlay hints
		vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
		vim.api.nvim_create_user_command(
			"ToggleHints",
			function()
				vim.lsp.inlay_hint.enable(
					not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 })
				)
			end,
			{ desc = "toggle inlay hints" }
		)

		-- Other LSP keymaps and user commands
		vim.keymap.set("i", "<c-s>", vim.lsp.buf.signature_help, {
			buffer = bufnr,
			desc = "signature help",
		})
		vim.api.nvim_buf_create_user_command(bufnr, "Rename", function(t)
			if t.args ~= "" then
				vim.lsp.buf.rename(t.args)
			else
				vim.api.nvim_input(
					("q:aRename %s<esc>"):format(vim.fn.expand("<cword>"))
				)
			end
		end, {
			nargs = "?",
			desc = "rename references to symbol under the cursor",
		})
	end,
})
