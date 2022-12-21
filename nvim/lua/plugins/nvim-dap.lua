return {
	"mfussenegger/nvim-dap",
	config = function()
		local loaded, dap = pcall(require, "dap")
		if not loaded then return end

		vim.api.nvim_create_user_command("DBreakpoint", dap.toggle_breakpoint, {})
		vim.api.nvim_create_user_command("DClear", dap.clear_breakpoints, {})
		vim.api.nvim_create_user_command("DContinue", dap.continue, {})
		vim.api.nvim_create_user_command("DRepl", dap.repl.toggle, {})
	end,
}
