for _, type in ipairs({ 'Error', 'Warn', 'Hint', 'Info' }) do
	local hl = 'DiagnosticSign' .. type
	vim.fn.sign_define(hl, { text = '', texthl = hl, numhl = hl })
end
