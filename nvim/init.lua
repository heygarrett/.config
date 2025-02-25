require("my.settings")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	local cmd_result = vim.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--single-branch",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	}):wait()

	if cmd_result.code ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ cmd_result.stderr, "WarningMsg" },
			{ "\nHint: use `nvim --clean` to launch Neovim without broken config" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end

vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup("my.plugins", {
	defaults = {
		lazy = true,
		version = "*",
	},
	dev = {
		path = "~/dev/repos",
		fallback = true,
	},
	install = {
		colorscheme = { "default" },
	},
})
