local map = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}

map('n', '<c-]>', '<cmd>Telescope lsp_definitions<cr>', opts)

vim.cmd([[
	command! Browse Telescope file_browser
	command! Find Telescope find_files
	command! Git Telescope git_files
	command! Grep Telescope live_grep
	command! Bufs Telescope buffers
	command! Help Telescope help_tags
	" LSP lists
	command! Refs Telescope lsp_references
	command! Defs Telescope lsp_definitions
	command! Imps Telescope lsp_implementations
	command! Acts Telescope lsp_code_actions
	command! Doc Telescope lsp_document_diagnostics
]])

local telescope = require('telescope')
telescope.setup {
	defaults = {
		-- prompt_prefix = '',
	},
	extensions = {
		fzf = {},
	}
}
telescope.load_extension('fzf')

