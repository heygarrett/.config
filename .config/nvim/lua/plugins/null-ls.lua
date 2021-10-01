local null_ls = require('null-ls')
local on_attach = require('utils/on-attach')

local sources = {
	null_ls.builtins.diagnostics.luacheck,
	null_ls.builtins.diagnostics.eslint_d,
	null_ls.builtins.formatting.prettierd,
}

null_ls.config({sources = sources})

require('lspconfig')['null-ls'].setup {
	on_attach = on_attach
}
