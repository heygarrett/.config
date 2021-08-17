local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end

return require('packer').startup(function()
	use 'wbthomason/packer.nvim'
	use 'neovim/nvim-lspconfig'
	use {'ms-jpq/coq_nvim', branch = 'coq'}
	use {'ms-jpq/coq.artifacts', branch = 'artifacts'}
	use 'itchyny/lightline.vim'
	use 'editorconfig/editorconfig-vim'
	use 'tpope/vim-sleuth'
	use 'tpope/vim-vinegar'
	use 'tpope/vim-fugitive'
	use 'tpope/vim-markdown'
	use 'keith/swift.vim'
end)
