vim.opt.expandtab = false
vim.opt.shiftwidth = 0
vim.opt.softtabstop = -1
vim.opt.tabstop = 4

vim.api.nvim_create_augroup("indentation", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	group = "indentation",
	callback = function()
		-- Override ftplugin indentation settings
		vim.opt_local.expandtab = vim.opt_global.expandtab:get()
		vim.opt_local.shiftwidth = vim.opt_global.shiftwidth:get()
		vim.opt_local.softtabstop = vim.opt_global.softtabstop:get()
		vim.opt_local.tabstop = vim.opt_global.tabstop:get()
		-- Run guess-indent
		if vim.opt.filetype:get() ~= "gitcommit" then
			vim.api.nvim_command("silent GuessIndent auto_cmd")
		end
		-- Use | for tabs and · for spaces
		vim.opt.listchars = { tab = "| ", trail = "·" }
		if vim.opt.expandtab:get() then
			local ms = "·" .. string.rep(" ", vim.opt.tabstop:get() - 1)
			-- TODO: Switch to leadmultispace when possible
			vim.opt.listchars:append({ multispace = ms })
		else
			vim.opt.listchars:append({ lead = "·" })
		end
	end
})
