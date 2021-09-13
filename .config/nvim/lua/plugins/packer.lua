vim.cmd([[autocmd BufWritePost packer.lua source <afile> | PackerCompile]])

local fn = vim.fn
local execute = vim.api.nvim_command
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
	fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
	execute 'packadd packer.nvim'
end

return require('packer').startup({
	function(use)
		use 'wbthomason/packer.nvim'
		use 'neovim/nvim-lspconfig'
		use 'folke/trouble.nvim'
		use {'ms-jpq/coq_nvim', branch = 'coq', run = ':COQdeps',
			requires = {'ms-jpq/coq.artifacts', branch = 'artifacts'}}
		use {'mfussenegger/nvim-lint', rocks = {'luacheck', 'lanes'}}
		use 'hoob3rt/lualine.nvim'
		use 'lukas-reineke/indent-blankline.nvim'
		use 'henrik/vim-indexed-search'
		use 'tpope/vim-sleuth'
		use 'tpope/vim-vinegar'
		use 'tpope/vim-fugitive'
		use 'tpope/vim-markdown'
		use 'editorconfig/editorconfig-vim'
		use {'apple/swift', rtp = 'utils/vim'}
	end,
	config = {
		git = {
			clone_timeout = false
		}
	}
})
