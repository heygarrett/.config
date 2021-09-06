return require('lualine').setup {
	options = {
		theme = 'dracula',
		section_separators = {' ', ' '},
		component_separators = {'|', '|'}
	},
	sections = {
		lualine_a = {'mode'}
	}
}
