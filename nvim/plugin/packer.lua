vim.api.nvim_create_autocmd("BufWritePost", {
	group = vim.api.nvim_create_augroup("packer", { clear = true }),
	pattern = "packer.lua",
	callback = function(t)
		for k, _ in pairs(package.loaded) do
			if k:match("^config") then package.loaded[k] = nil end
		end
		dofile(t.file)
		require("packer").compile()
	end,
})

local packer_bootstrap
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	packer_bootstrap = vim.fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
end

require("packer").startup({
	function(use)
		use({
			"gpanders/editorconfig.nvim",
			"wbthomason/packer.nvim",
			require("config.FTerm"),
			require("config.catppuccin"),
			require("config.gitsigns"),
			require("config.guess-indent"),
			require("config.null-ls"),
			require("config.nvim-lspconfig"),
			require("config.nvim-treesitter"),
			require("config.telescope"),
			require("config.vim-indexed-search"),
		})

		if packer_bootstrap then require("packer").sync() end
	end,

	config = {
		display = {
			open_fn = require("packer/util").float,
		},
	},
})
