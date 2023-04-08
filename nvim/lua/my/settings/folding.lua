function _G.fold_text()
	local first_line =
		vim.api.nvim_buf_get_lines(0, vim.v.foldstart - 1, vim.v.foldstart, true)[1]
	local preview = first_line:gsub("\t", (" "):rep(vim.bo.tabstop))
	local number_of_lines = vim.v.foldend - vim.v.foldstart
	local foldtext = ("%s +- %d lines below the fold -+"):format(preview, number_of_lines)
	return foldtext
end

vim.o.foldenable = false
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldmethod = "expr"
vim.o.foldtext = "v:lua.fold_text()"
vim.opt.fillchars:append({ fold = " " })

vim.api.nvim_create_autocmd("BufEnter", {
	desc = "Enable folding and expand all folds",
	group = vim.api.nvim_create_augroup("folds", { clear = true }),
	callback = function()
		if vim.wo.foldenable or vim.bo.buftype ~= "" then
			return
		end
		vim.schedule(
			function()
				vim.cmd.normal({
					args = { "zR" },
					mods = { emsg_silent = true },
				})
			end
		)
	end,
})
