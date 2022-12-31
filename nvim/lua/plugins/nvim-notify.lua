return {
	"rcarriga/nvim-notify",
	version = "*",
	lazy = false,
	config = function()
		local notify = require("notify")
		notify.setup({
			render = "minimal",
			minimum_width = 0,
			timeout = 1000,
		})

		vim.notify = notify
	end,
}
