-- vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

local cmp = require('cmp')

cmp.setup({
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end
	},
	sources = {
		{name = 'nvim_lsp'},
		{name = 'luasnip'},
		{name = 'buffer'},
		{name = 'nvim_lua'},
	}
})
