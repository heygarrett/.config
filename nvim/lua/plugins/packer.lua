vim.api.nvim_command('autocmd BufWritePost packer.lua source <afile> | PackerCompile')

local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.fn.system({ 'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path })
	vim.api.nvim_command('packadd packer.nvim')
end

require('packer').startup {
	{
		-- Self-manage
		'wbthomason/packer.nvim',

		-- No configs
		'editorconfig/editorconfig-vim',
		'farmergreg/vim-lastplace',
		'tpope/vim-fugitive',
		'tpope/vim-sleuth',
		'tpope/vim-vinegar',

		-- Configs
		require('plugins/Comment'),
		require('plugins/lualine'),
		require('plugins/nvim-lspconfig'),
		require('plugins/nvim-treesitter'),
		require('plugins/telescope'),
		require('plugins/tokyonight'),
		require('plugins/vim-indexed-search'),
		require('plugins/vim-markdown'),
	},
	config = {
		display = {
			open_fn = require('packer.util').float,
		}
	},
}
