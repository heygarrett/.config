require("my.settings")
vim.cmd.runtime({
	bang = true,
	args = { "lua/my/plugins/*.lua" },
})
