local on_attach = function(_, bufnr)
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
	local opts = { noremap = true, silent = true }

	buf_set_keymap('i', '<c-s>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
	buf_set_keymap('n', '<leader>d', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
	buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<cr>', opts)
	buf_set_keymap('n', '<leader>h', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
	buf_set_keymap('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
	buf_set_keymap('n', '<leader>s', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
	buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts)
	buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>', opts)
end

return on_attach
