local bootstrap
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	bootstrap = vim.fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	vim.cmd.packadd({
		args = { "packer.nvim" },
	})
end
local packer = require("packer")
local packer_util = require("packer.util")

vim.api.nvim_create_autocmd("BufWritePost", {
	group = vim.api.nvim_create_augroup("packer", { clear = true }),
	pattern = "packer.lua",
	callback = function(t)
		for k, _ in pairs(package.loaded) do
			if k:match("^config") then package.loaded[k] = nil end
		end
		dofile(t.file)
		packer.compile()
	end,
})

packer.startup({
	function(use)
		use({
			"gpanders/editorconfig.nvim",
			"wbthomason/packer.nvim",
			require("config.FTerm"),
			require("config.catppuccin"),
			require("config.gitsigns"),
			require("config.guess-indent"),
			require("config.mason"),
			require("config.null-ls"),
			require("config.nvim-lspconfig"),
			require("config.nvim-notify"),
			require("config.nvim-snippy"),
			require("config.nvim-treesitter"),
			require("config.telescope"),
		})

		if bootstrap then packer.sync() end
	end,

	config = {
		display = {
			open_fn = packer_util.float,
		},
	},
})
