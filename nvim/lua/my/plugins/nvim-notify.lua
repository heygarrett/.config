return {
	"https://github.com/rcarriga/nvim-notify",
	opts = {
		render = "minimal",
		minimum_width = 0,
		timeout = 1000,
	},
	config = function(_, opts)
		local notify = require("notify")
		notify.setup(opts)
		vim.notify = vim.schedule_wrap(notify.notify)
	end,
}
