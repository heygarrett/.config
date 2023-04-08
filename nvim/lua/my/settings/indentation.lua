-- Default to tabs
vim.o.expandtab = false
vim.o.shiftwidth = 0
vim.o.softtabstop = -1
vim.o.tabstop = 4
vim.opt.listchars = { lead = "·", tab = "| ", trail = "·" }

-- Don't run editorconfig automatically
vim.g.editorconfig = false

vim.api.nvim_create_autocmd("BufWinEnter", {
	desc = "indentation settings",
	group = vim.api.nvim_create_augroup("indentation", { clear = true }),
	callback = function(args)
		-- Override expandtab set by ftplugins
		---@diagnostic disable-next-line: undefined-field
		vim.bo.expandtab = vim.go.expandtab

		-- Run editorconfig
		require("editorconfig").config(args.buf)

		-- Run guess-indent (which defers to editorconfig)
		local gi_loaded, _ = pcall(require, "guess-indent")
		if gi_loaded then
			vim.cmd.GuessIndent({
				args = { "auto_cmd" },
				mods = { silent = true },
			})
		end

		-- Always use value of tabstop for shiftwidth and softtabstop
		---@diagnostic disable: undefined-field
		vim.bo.shiftwidth = vim.go.shiftwidth
		vim.bo.softtabstop = vim.go.softtabstop
		---@diagnostic enable: undefined-field

		if vim.bo.expandtab then
			-- Set whitespace characters for indentation with spaces
			vim.opt_local.listchars = vim.tbl_extend(
				"force",
				vim.opt_global.listchars:get(),
				{ leadmultispace = ":" .. (" "):rep(vim.bo.tabstop - 1) }
			)
		else
			-- Remove leadmultispace from listchars
			---@diagnostic disable-next-line: undefined-field
			vim.wo.listchars = vim.go.listchars
			-- Override tabstop if we're using tabs
			---@diagnostic disable-next-line: undefined-field
			vim.bo.tabstop = vim.go.tabstop
		end
	end,
})
