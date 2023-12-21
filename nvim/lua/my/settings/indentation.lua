-- Default to tabs
vim.o.expandtab = false
vim.o.shiftwidth = 0
vim.o.softtabstop = -1
vim.o.tabstop = 4
vim.opt.listchars = { space = "·", tab = "| " }

-- Don't run editorconfig automatically
vim.g.editorconfig = false

local group = vim.api.nvim_create_augroup("indentation", { clear = true })
vim.api.nvim_create_autocmd("BufWinEnter", {
	desc = "indentation settings",
	group = group,
	callback = function(args)
		-- Override expandtab set by ftplugins
		vim.bo.expandtab = vim.go.expandtab

		-- Load editorconfig
		require("editorconfig").config(args.buf)

		-- Run guess-indent
		local guess_indent_loaded, _ = pcall(require, "guess-indent")
		if guess_indent_loaded then
			vim.cmd.GuessIndent({
				args = { "auto_cmd" },
				mods = { silent = true },
			})
		end

		-- Finalize listchars and reset softtabstop
		vim.cmd.Relist()
	end,
})

vim.api.nvim_create_user_command("Relist", function()
	if vim.bo.expandtab then
		-- Set whitespace characters for indentation with spaces
		vim.opt_local.listchars = vim.tbl_extend(
			"force",
			vim.opt_global.listchars:get(),
			{ leadmultispace = ":" .. (" "):rep(vim.bo.shiftwidth - 1) }
		)
	else
		-- Remove leadmultispace from listchars
		vim.wo.listchars = vim.go.listchars
		-- Override tabstop if we're using tabs
		vim.bo.tabstop = vim.go.tabstop
	end

	-- Reset softtabstop
	vim.bo.softtabstop = vim.go.softtabstop
end, { desc = "re-set listchars" })
