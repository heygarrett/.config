local refactoring = function() return require("refactoring") end

return {
	"https://github.com/ThePrimeagen/refactoring.nvim",
	lazy = true,
	init = function()
		vim.api.nvim_create_user_command(
			"Refactor",
			function() refactoring().select_refactor() end,
			{
				range = true,
				desc = "open refactoring.nvim menu",
			}
		)
	end,
	config = function()
		vim.o.shiftwidth = vim.o.tabstop
		refactoring().setup()
	end,
}
