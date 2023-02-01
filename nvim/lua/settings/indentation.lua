-- Defaults for tabs
vim.o.expandtab = false
vim.o.shiftwidth = 0
vim.o.softtabstop = -1
vim.o.tabstop = 4
vim.opt.listchars = { lead = "·", tab = "| ", trail = "·" }

vim.api.nvim_create_autocmd("BufWinEnter", {
	group = vim.api.nvim_create_augroup("indentation", { clear = true }),
	callback = function()
		-- Override ftplugin indentation settings
		vim.bo.shiftwidth = vim.go.shiftwidth
		vim.bo.softtabstop = vim.go.softtabstop

		if not vim.b.editorconfig or next(vim.b.editorconfig) == nil then
			-- Override only if not set by editorconfig
			vim.bo.expandtab = vim.go.expandtab
			vim.bo.tabstop = vim.go.tabstop

			-- Run guess-indent
			if package.loaded["guess-indent"] then
				vim.cmd.GuessIndent({
					args = { "auto_cmd" },
					mods = { silent = true },
				})
			end
		end

		-- Set whitespace characters for indentation with spaces
		if vim.bo.expandtab then
			vim.opt_local.listchars:append({
				leadmultispace = ":" .. (" "):rep(vim.bo.tabstop - 1),
			})
		end
	end,
})
