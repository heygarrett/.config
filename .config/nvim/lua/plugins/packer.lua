vim.api.nvim_command('autocmd BufWritePost packer.lua source <afile> | PackerCompile')
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
	vim.api.nvim_command('packadd packer.nvim')
end

return require('packer').startup({
	function(use)

		-- configs in lua/plugins
		use 'wbthomason/packer.nvim'
		use {'neovim/nvim-lspconfig', rocks = {'luacheck', 'lanes'}}
		use {'ms-jpq/coq_nvim', run = ':COQdeps', requires = {
			'ms-jpq/coq.thirdparty'}}
		use {'nvim-telescope/telescope.nvim', requires = {
			'nvim-lua/plenary.nvim',
			{'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}}}
		use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
		use 'hoob3rt/lualine.nvim'
		use 'henrik/vim-indexed-search'

		-- no configs
		-- use 'Darazaki/indent-o-matic'
		use 'tpope/vim-sleuth'
		use 'lukas-reineke/indent-blankline.nvim'
		-- use 'tpope/vim-markdown'
		use 'plasticboy/vim-markdown'
		use 'tpope/vim-commentary'
		use 'editorconfig/editorconfig-vim'
		use 'farmergreg/vim-lastplace'

	end,
	config = {
		['git.clone_timeout'] = false
	}
})
