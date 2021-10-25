vim.api.nvim_command('autocmd BufWritePost packer.lua source <afile> | PackerCompile')

local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.fn.system({ 'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path })
	vim.api.nvim_command('packadd packer.nvim')
end

require('packer').startup {
	function(use)
		use 'wbthomason/packer.nvim'

		use(require('plugins/indexed-search'))
		use(require('plugins/lspconfig'))
		use(require('plugins/comment'))
		use(require('plugins/lualine'))
		use(require('plugins/vim-markdown'))
		use(require('plugins/lsp_signature'))
		use(require('plugins/treesitter'))

		-- No configs
		use 'editorconfig/editorconfig-vim'
		use 'farmergreg/vim-lastplace'
		use 'tpope/vim-sleuth'
		use 'tpope/vim-vinegar'

	end
}
