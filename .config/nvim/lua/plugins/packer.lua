vim.cmd([[autocmd BufWritePost packer.lua source <afile> | PackerCompile]])
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
		use {'ms-jpq/coq_nvim', branch = 'coq', run = ':COQdeps', requires = {
			'ms-jpq/coq.artifacts', branch = 'artifacts'}}
		use 'hoob3rt/lualine.nvim'
		use 'henrik/vim-indexed-search'

		-- no configs
		use 'tpope/vim-sleuth'
		use 'tpope/vim-vinegar'
		use 'tpope/vim-fugitive'
		use 'tpope/vim-markdown'
		use 'tpope/vim-commentary'
		use 'editorconfig/editorconfig-vim'
		use 'lukas-reineke/indent-blankline.nvim'
		use 'farmergreg/vim-lastplace'
		use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
		use {'nvim-telescope/telescope.nvim', requires = {
			'nvim-lua/plenary.nvim',
			{'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }}}

	end,
	config = {
		git = {
			clone_timeout = false
		}
	}
})
