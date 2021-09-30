vim.api.nvim_command('autocmd BufWritePost packer.lua source <afile> | PackerCompile')
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
	vim.api.nvim_command('packadd packer.nvim')
end

return require('packer').startup({
	function(use)

		-- Configs in lua/plugins
		use 'wbthomason/packer.nvim'
		use {'neovim/nvim-lspconfig', rocks = {'luacheck', 'lanes'}}
		use {'hrsh7th/nvim-cmp', requires = {
			use 'hrsh7th/cmp-nvim-lsp',
			use 'hrsh7th/cmp-buffer',
			use 'hrsh7th/cmp-nvim-lua',
			use 'hrsh7th/vim-vsnip',
			use 'hrsh7th/cmp-vsnip',
			use 'ray-x/cmp-treesitter'}}
		use {'nvim-telescope/telescope.nvim', requires = {
			'nvim-lua/plenary.nvim',
			{'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}}}
		use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
		use 'hoob3rt/lualine.nvim'
		use 'henrik/vim-indexed-search'

		-- No configs
		use 'tpope/vim-sleuth'
		use 'lukas-reineke/indent-blankline.nvim'
		use 'plasticboy/vim-markdown'
		use 'tpope/vim-commentary'
		use 'editorconfig/editorconfig-vim'
		use 'farmergreg/vim-lastplace'

		-- Parking
		-- use 'Darazaki/indent-o-matic'
		-- use 'tpope/vim-markdown'

	end,
	config = {
		['git.clone_timeout'] = false
	}
})
