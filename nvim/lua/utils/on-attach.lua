local on_attach = function(_, bufnr)
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Diagnostics
	vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float)
	vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
	vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
	vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

	-- LSP settings
	local opts = { buffer = bufnr }
	vim.keymap.set('i', '<c-s>', vim.lsp.buf.signature_help, opts)
	vim.keymap.set('n', '<leader>f', vim.lsp.buf.formatting, opts)
	vim.keymap.set('n', '<leader>h', vim.lsp.buf.hover, opts)
	vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, opts)
	vim.keymap.set('n', '<leader>s', vim.lsp.buf.definition, opts)
end

return on_attach
