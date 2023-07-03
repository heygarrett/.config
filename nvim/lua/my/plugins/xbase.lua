return {
	"https://github.com/kkharji/xbase",
	lazy = true,
	ft = "swift",
	config = function()
		require("lspconfig").sourcekit.setup({
			capabilities = require("cmp_nvim_lsp").default_capabilities(),
		})
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
	end,
}
