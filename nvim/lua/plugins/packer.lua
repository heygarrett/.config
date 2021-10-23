vim.api.nvim_command('autocmd BufWritePost packer.lua source <afile> | PackerCompile')

local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.fn.system({ 'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path })
	vim.api.nvim_command('packadd packer.nvim')
end

return require('packer').startup {
	function(use)
		use 'wbthomason/packer.nvim'

		-- Configs in lua/plugins
		use 'henrik/vim-indexed-search'
		use 'nvim-lualine/lualine.nvim'
		use 'neovim/nvim-lspconfig'
		use 'nvim-lua/plenary.nvim'
		use 'plasticboy/vim-markdown'
		use 'ray-x/lsp_signature.nvim'
		use { 'jose-elias-alvarez/null-ls.nvim', rocks = { 'luacheck', 'lanes' }}
		use { 'nvim-telescope/telescope.nvim', requires = {
			{ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }}}
		use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

		-- No configs
		use 'editorconfig/editorconfig-vim'
		use 'farmergreg/vim-lastplace'
		use { 'numToStr/Comment.nvim', config = function() require('Comment').setup() end }
		use 'tpope/vim-sleuth'

	end
}