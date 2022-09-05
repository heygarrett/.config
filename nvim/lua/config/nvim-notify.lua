return {
	"rcarriga/nvim-notify",
	config = function()
		local loaded, notify = pcall(require, "notify")
		if not loaded then return end

		notify.setup({
			render = "minimal",
			minimum_width = 0,
		})

		vim.notify = notify
	end,
}
