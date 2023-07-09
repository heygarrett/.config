return {
	"https://github.com/kkharji/xbase",
	lazy = true,
	ft = "swift",
	config = function()
		require("xbase").setup({
			mappings = { enable = false },
		})

		local pickers = require("xbase.pickers")
		vim.api.nvim_create_user_command(
			"Build",
			function() pickers.build() end,
			{ desc = "xbase build" }
		)
		vim.api.nvim_create_user_command(
			"Run",
			function() pickers.run() end,
			{ desc = "xbase run" }
		)
		vim.api.nvim_create_user_command(
			"Watch",
			function() pickers.watch({}) end,
			{ desc = "xbase watch" }
		)
		vim.api.nvim_create_user_command(
			"Log",
			function() require("xbase.logger").toggle(false, true) end,
			{ desc = "xbase log" }
		)
	end,
}
