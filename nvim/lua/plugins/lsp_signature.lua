return {
	'ray-x/lsp_signature.nvim',
	config = function()
		require('lsp_signature').setup {
			floating_window = false,
		}
	end
}
