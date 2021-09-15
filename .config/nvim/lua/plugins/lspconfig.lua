vim.opt.signcolumn = 'yes'

local nvim_lsp = require('lspconfig')
local coq = require('plugins/coq')
local capabilities = vim.lsp.protocol.make_client_capabilities()

local on_attach = function(_, bufnr)
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

	-- Mappings.
	local opts = { noremap=true, silent=true }

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	buf_set_keymap('n', '<leader>dec', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	buf_set_keymap('n', '<leader>def', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
	buf_set_keymap('n', '<leader>hov', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
	buf_set_keymap('n', '<leader>imp', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	buf_set_keymap('n', '<leader>sig', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	buf_set_keymap('n', '<leader>typ', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	buf_set_keymap('n', '<leader>act', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
	buf_set_keymap('n', '<leader>ref', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
	buf_set_keymap('n', '<leader>sld', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
	buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
	buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
	buf_set_keymap('n', '<leader>dll', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
	buf_set_keymap('n', '<leader>fmt', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

local signs = { Error = '🚫', Warning = '⚠️', Hint = '💡', Information = 'ℹ️' }
for type, icon in pairs(signs) do
	local hl = "LspDiagnosticsSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

local servers = {
	'pyright',
	'rust_analyzer',
	'sourcekit',
	'tsserver',
}
for _, lsp in ipairs(servers) do
	nvim_lsp[lsp].setup(coq.lsp_ensure_capabilities({
		on_attach = on_attach,
		capabilities = capabilities
	}))
end

-- TODO clean up efm config

local function get_command_path(project, global)
	local f = io.open(project .. global, 'r')
	if f ~= nil then
		io.close(f)
		return project .. global .. ' '
	else
		return global .. ' '
	end
end

local prettier = {
	formatCommand = get_command_path('./node_modules/.bin', 'prettier') .. '--stdin-filepath ${INPUT}',
	formatStdin = true,
}

local eslint = {
	lintCommand = get_command_path('./node_modules/.bin', 'eslint') .. '-f compact --stdin --stdin-filename ${INPUT}',
	lintIgnoreExitCode = true,
	lintStdin = true,
	lintFormats = {
		'%f: line %l, col %c, %trror - %m',
		'%f: line %l, col %c, %tarning - %m'
	}
}

local luacheck = {
	lintCommand = 'luacheck --formatter plain --codes -',
	lintIgnoreExitCode = true,
	lintStdin = true,
	lintFormats = {'%f:%l:%c: (%t%n) %m'},
}

local languages = {
	typescript = {eslint, prettier},
	javascript = {eslint, prettier},
	svelte = {eslint},
	lua = {luacheck},
}

nvim_lsp.efm.setup {
	init_options = {documentFormatting = true},
	filetypes = vim.tbl_keys(languages),
	settings = {
		rootMarkers = {'.git/'},
		languages = languages
	},
	on_attach = on_attach
}
