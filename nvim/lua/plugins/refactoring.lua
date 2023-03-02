local refactoring = function() return require("refactoring") end

return {
	"https://github.com/ThePrimeagen/refactoring.nvim",
	lazy = true,
	init = function()
		vim.api.nvim_create_user_command(
			"Refactor",
			refactoring().select_refactor,
			{ range = true }
		)
	end,
	config = function()
		vim.o.shiftwidth = vim.o.tabstop
		refactoring().setup()
	end,
}
