local dap = function() return require("dap") end

return {
	"mfussenegger/nvim-dap",
	version = "*",
	init = function()
		vim.api.nvim_create_user_command(
			"DBreakpoint",
			function() dap().toggle_breakpoint() end,
			{}
		)
		vim.api.nvim_create_user_command(
			"DClear",
			function() dap().clear_breakpoints() end,
			{}
		)
		vim.api.nvim_create_user_command("DContinue", function() dap().continue() end, {})
		vim.api.nvim_create_user_command("DRepl", function() dap().repl.toggle() end, {})
	end,
}
