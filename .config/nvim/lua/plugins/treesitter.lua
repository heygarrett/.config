require('nvim-treesitter.configs').setup {
	ensure_installed = {
		'fish',
		'lua',
		'vim',
		'swift',
		'python',
		'rust',
		'json',
		'typescript',
		'svelte',
	},
	highlight = {
		enable = true
	}
}
