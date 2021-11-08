vim.api.nvim_command('autocmd BufWritePost packer.lua source <afile> | PackerCompile')

local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	Bootstrap = vim.fn.system {
		'git', 'clone', '--depth', '1',
		'https://github.com/wbthomason/packer.nvim',
		install_path
	}
end

require('packer').startup {
	function(use)
		use {
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
		}

		if Bootstrap then
			require('packer').sync()
		end
	end,

	config = {
		display = {
			open_fn = require('packer.util').float,
		}
	},
}
