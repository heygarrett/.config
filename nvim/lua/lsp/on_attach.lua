vim.api.nvim_create_autocmd("LspAttach", {
	desc = "LSP options, commands and keymaps",
	group = vim.api.nvim_create_augroup("lsp", { clear = true }),
	callback = function(args)
		local bufnr = args.buf
		local client = vim.lsp.get_client_by_id(args.data.client_id)

		require("lsp.diagnostics")

		-- Use omnicomplete with LSP
		if client.supports_method("textDocument/completion") then
			require("lsp.completion").setup(bufnr)
		end

		-- Formatting user command and autocmd
		if client.supports_method("textDocument/formatting") then
			require("lsp.formatting").setup(bufnr)
		end

		-- Set border of floating window preview
		local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
		---@diagnostic disable-next-line: duplicate-set-field
		function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
			opts.border = "single"
			return orig_util_open_floating_preview(contents, syntax, opts, ...)
		end

		-- Other LSP keymaps and user commands
		vim.keymap.set("n", "<leader>h", vim.lsp.buf.hover, {
			buffer = bufnr,
			desc = "display hover information",
		})
		vim.keymap.set("i", "<c-s>", vim.lsp.buf.signature_help, {
			buffer = bufnr,
			desc = "signature help",
		})
		vim.api.nvim_buf_create_user_command(
			bufnr,
			"Def",
			vim.lsp.buf.definition,
			{ desc = "go to LSP definition" }
		)
		vim.api.nvim_buf_create_user_command(
			bufnr,
			"Actions",
			function() vim.lsp.buf.code_action() end,
			{ desc = "code actions" }
		)
		vim.api.nvim_buf_create_user_command(bufnr, "Rename", function(t)
			if t.args ~= "" then
				vim.lsp.buf.rename(t.args)
			else
				local keys = ("q:aRename %s%s"):format(
					vim.fn.expand("<cword>"),
					vim.api.nvim_eval([["\<esc>"]])
				)
				vim.api.nvim_feedkeys(keys, "in", false)
			end
		end, {
			nargs = "?",
			desc = "rename references to symbol under the cursor",
		})
	end,
})
