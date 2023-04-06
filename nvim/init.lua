require("my.settings")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--single-branch",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.runtimepath:prepend(lazypath)
require("lazy").setup("my.plugins", {
	defaults = {
		lazy = false,
	},
	dev = {
		path = "~/dev/repos",
		fallback = true,
	},
	install = {
		colorscheme = { "kanagawa" },
	},
})
