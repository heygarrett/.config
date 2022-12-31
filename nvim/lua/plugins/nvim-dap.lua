local dap = function() return require("dap") end

return {
	"mfussenegger/nvim-dap",
	init = function()
		vim.api.nvim_create_user_command("DBreakpoint", dap().toggle_breakpoint, {})
		vim.api.nvim_create_user_command("DClear", dap().clear_breakpoints, {})
		vim.api.nvim_create_user_command("DContinue", dap().continue, {})
		vim.api.nvim_create_user_command("DRepl", dap().repl.toggle, {})
	end,
}
