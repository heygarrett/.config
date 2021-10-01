vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

local cmp = require('cmp')

cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end
	},
	mapping = {
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.close(),
		['<CR>'] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true
		}),
	},
	sources = {
		{name = 'vsnip'},
		{name = 'nvim_lsp'},
		{name = 'buffer'},
		{name = 'nvim_lua'},
		{name = 'path'},
	}
})
