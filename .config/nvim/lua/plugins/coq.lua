vim.g.coq_settings = {
	auto_start = true,
	clients = {
		['tmux.enabled'] = false,
		['snippets.enabled'] = false,
		['snippets.warn'] = {},
	},
	['keymap.jump_to_mark'] = '<c-n>',
}

require('coq_3p') {
	{src = 'nvimlua', short_name = 'nLUA'}
}

return require('coq')
