local null_ls = require('null-ls')
local on_attach = require('utils/on-attach')

local sources = {
	null_ls.builtins.diagnostics.luacheck,
}

null_ls.config({ sources = sources })

local lspconfig = require('lspconfig')
lspconfig['null-ls'].setup {
	on_attach = on_attach,
	root_dir = lspconfig.util.root_pattern('.luacheckrc')
}
