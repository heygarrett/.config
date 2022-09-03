return {
	"rcarriga/nvim-notify",
	config = function()
		local loaded, notify = pcall(require, "notify")
		if not loaded then return end

		notify.setup({
			render = "minimal",
		})

		vim.notify = notify
	end,
}
