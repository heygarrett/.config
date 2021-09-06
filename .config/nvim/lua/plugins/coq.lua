vim.g.coq_settings = {
	auto_start = true,
	clients = {
		['tmux.enabled'] = false,
		['snippets.enabled'] = false
	},
	['keymap.jump_to_mark'] = '<c-n>',
}

local coq = require 'coq'
