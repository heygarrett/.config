-- Defaults for tabs
vim.opt.expandtab = false
vim.opt.listchars = { lead = "·", tab = "| ", trail = "·" }
vim.opt.shiftwidth = 0
vim.opt.softtabstop = -1
vim.opt.tabstop = 4

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("indentation", { clear = true }),
	callback = function()
		-- Override ftplugin indentation settings
		vim.opt_local.expandtab = vim.opt_global.expandtab:get()
		vim.opt_local.listchars = vim.opt_global.listchars:get()
		vim.opt_local.shiftwidth = vim.opt_global.shiftwidth:get()
		vim.opt_local.softtabstop = vim.opt_global.softtabstop:get()
		vim.opt_local.tabstop = vim.opt_global.tabstop:get()
		-- Run guess-indent
		local success, _ = pcall(require, "guess-indent")
		if success then vim.api.nvim_command("silent GuessIndent auto_cmd") end
		-- Set whitespace characters for indentation with spaces
		if vim.opt_local.expandtab:get() then
			-- Switch to leadmultispace in Neovim 0.8
			local ms = ":" .. string.rep(" ", vim.opt_local.tabstop:get() - 1)
			vim.opt_local.listchars:remove("lead")
			vim.opt_local.listchars:append({ multispace = ms })
		end
	end,
})
