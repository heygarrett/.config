return {
	'folke/tokyonight.nvim',
	config = function()
		vim.g.tokyonight_style = 'night'
		vim.cmd([[colorscheme tokyonight]])
	end
}
