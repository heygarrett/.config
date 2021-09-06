-- --------------------------------------------------------------------------------
--  plugins
-- --------------------------------------------------------------------------------
vim.cmd([[autocmd BufWritePost plugins.lua source <afile> | PackerCompile]])

require('plugins')

vim.g.coq_settings = {
	auto_start = true,
	clients = {
		['tmux.enabled'] = false,
		['snippets.enabled'] = false
	},
	['keymap.jump_to_mark'] = '<c-n>',
}

local coq = require 'coq'
local nvim_lsp = require 'lspconfig'
local capabilities = vim.lsp.protocol.make_client_capabilities()
local on_attach = function(client, bufnr)
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
	local opts = { noremap = true, silent = true }

	buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
	buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	buf_set_keymap('n', '<Leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	buf_set_keymap('n', '<Leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
	buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
	buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
	buf_set_keymap('n', '<Leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
	buf_set_keymap('n', '<Leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
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

local lint = require('lint')
lint.linters_by_ft = {
	javascript = {'eslint'},
	typescript = {'eslint'},
}
lint.linters.eslint.cmd = './node_modules/.bin/eslint'
vim.cmd([[au BufEnter,InsertLeave * lua require('lint').try_lint()]])

local signs = { Error = '🚫', Warning = '⚠️', Hint = '💡', Information = 'ℹ️' }
for type, icon in pairs(signs) do
	local hl = "LspDiagnosticsSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end


function LightlineFileFormat()
	if vim.o.filetype == 'netrw' then
		return vim.fn.getcwd()
	else
		return vim.fn.expand('%:F')
	end
end

vim.g.lightline = {
	colorscheme = 'dracula_pro',
	active = {
		left = {
			{'mode', 'paste'},
			{'currentfunction', 'readonly', 'filename', 'modified'}
		},
		component_function = {
			filename = LightlineFileFormat()
		}

	}
}

-- --------------------------------------------------------------------------------
--  misc. functionality
-- --------------------------------------------------------------------------------
vim.o.showmode = false
vim.o.signcolumn = 'yes'
vim.o.cmdheight = 2
vim.o.confirm = true
vim.g.indexed_search_numbered_only = 1

-- --------------------------------------------------------------------------------
--  languages
-- --------------------------------------------------------------------------------
vim.g.python3_host_prog = vim.env.HOME .. "/.local/venvs/nvim/bin/python"

-- --------------------------------------------------------------------------------
--  netrw
-- --------------------------------------------------------------------------------
vim.cmd([[autocmd FileType netrw setlocal nocursorcolumn]])
vim.g.netrw_liststyle = 3
-- let g:netrw_keepdir = 0

-- --------------------------------------------------------------------------------
--  displaying text
-- --------------------------------------------------------------------------------
vim.cmd([[
	set termguicolors
	packadd! dracula_pro
	let g:dracula_colorterm = 0
	colorscheme dracula_pro
]])

vim.o.number = true
vim.o.scrolloff = 3
vim.o.linebreak = true

vim.o.list = true

-- --------------------------------------------------------------------------------
--  syntax, highlighting, and spelling
-- --------------------------------------------------------------------------------
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.cursorline = true
-- set cursorcolumn

vim.cmd([[highlight clear SignColumn]])

-- --------------------------------------------------------------------------------
--  multiple windows
-- --------------------------------------------------------------------------------
vim.o.laststatus = 2
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.hidden = true

-- --------------------------------------------------------------------------------
--  terminal
-- --------------------------------------------------------------------------------
vim.cmd([[autocmd TermOpen * startinsert]])
vim.cmd([[autocmd TermOpen * setlocal nonumber nocursorline nocursorcolumn]])
vim.o.title = true

-- --------------------------------------------------------------------------------
--  using the mouse
-- --------------------------------------------------------------------------------
vim.o.mouse = 'a'

-- --------------------------------------------------------------------------------
--  selecting text
-- --------------------------------------------------------------------------------
vim.o.clipboard = 'unnamedplus'

-- --------------------------------------------------------------------------------
--  editing text
-- --------------------------------------------------------------------------------
vim.o.showmatch = true

-- When editing a file, always jump to the last cursor position
vim.cmd([[autocmd BufReadPost * if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit' | exe "normal! g`\"" | endif]])

-- --------------------------------------------------------------------------------
--  tabs and indenting
-- --------------------------------------------------------------------------------
-- Indenting defaults (does not override vim-sleuth's indenting detection)
vim.cmd([[
	filetype plugin indent on
	autocmd FileType * setlocal noexpandtab tabstop=4 softtabstop=4 shiftwidth=4
]])

-- --------------------------------------------------------------------------------
--  folding
-- --------------------------------------------------------------------------------
vim.o.foldmethod = 'indent'
vim.o.foldenable = false

-- --------------------------------------------------------------------------------
--  mapping
-- --------------------------------------------------------------------------------
vim.api.nvim_set_keymap('n', 'j', 'gj', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'k', 'gk', { noremap = true, silent = true })

-- --------------------------------------------------------------------------------
--  command line editing
-- --------------------------------------------------------------------------------
vim.o.history = 1000
vim.o.undolevels = 1000
