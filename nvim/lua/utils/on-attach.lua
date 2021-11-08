local on_attach = function(_, bufnr)
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
	local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

	-- Native completion
	buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	local opts = { noremap=true, silent=true }

	-- Keymaps
	buf_set_keymap('n', '<leader>d', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>', opts)
	buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<cr>', opts)
	buf_set_keymap('n', '<leader>h', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
	buf_set_keymap('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
	buf_set_keymap('n', '<leader>s', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
	buf_set_keymap('n', '<leader>t', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
	buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>', opts)
	buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<cr>', opts)
end

return on_attach
