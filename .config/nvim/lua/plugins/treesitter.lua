require('nvim-treesitter.configs').setup {
	ensure_installed = {
		'lua',
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
