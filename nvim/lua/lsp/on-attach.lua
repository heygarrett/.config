local on_attach = function(client, bufnr)
	-- Disable formatting for tsserver
	if client.name == "tsserver" then
		client.resolved_capabilities.document_formatting = false
	end

	-- Use omnicomplete with LSP
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Diagnostics
	vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float)
	vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
	vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
	vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

	-- LSP settings
	local opts = { buffer = bufnr }
	vim.api.nvim_create_user_command("Actions", vim.lsp.buf.code_action, {})
	vim.api.nvim_create_user_command("Def", vim.lsp.buf.definition, {})
	vim.api.nvim_create_user_command("Format", vim.lsp.buf.formatting, {})
	vim.api.nvim_create_user_command("Rename", function(t)
		vim.lsp.buf.rename(t.args)
	end, { nargs = 1 })
	vim.keymap.set("i", "<c-s>", vim.lsp.buf.signature_help, opts)
	vim.keymap.set("n", "<leader>h", vim.lsp.buf.hover, opts)
end

return on_attach
