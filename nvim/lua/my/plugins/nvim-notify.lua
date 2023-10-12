return {
	"https://github.com/rcarriga/nvim-notify",
	config = function()
		local notify = require("notify")
		notify.setup({
			render = "minimal",
			minimum_width = 0,
			timeout = 1000,
		})

		vim.notify = vim.schedule_wrap(notify.notify)
	end,
}
