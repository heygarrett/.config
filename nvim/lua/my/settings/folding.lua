function _G.fold_text()
	local first_line = vim.api.nvim_buf_get_lines(
		0,
		vim.v.foldstart - 1,
		vim.v.foldstart,
		true
	)[1]
	local preview = first_line:gsub("\t", (" "):rep(vim.bo.tabstop))
	local number_of_lines = vim.v.foldend - vim.v.foldstart
	local foldtext = ("%s +- %d line(s) below the fold -+"):format(
		preview,
		number_of_lines
	)
	return foldtext
end

vim.o.foldenable = false
vim.o.foldmethod = "indent"
vim.o.foldtext = "v:lua.fold_text()"
vim.opt.fillchars:append({ fold = " " })
vim.g.markdown_folding = 1

local group = vim.api.nvim_create_augroup("folds", { clear = true })
vim.api.nvim_create_autocmd("BufWinEnter", {
	desc = "Enable folding and expand all folds",
	group = group,
	callback = function()
		if vim.bo.buftype ~= "" then
			return
		end
		vim.cmd.normal({
			args = { "zR" },
			mods = { emsg_silent = true },
		})
	end,
})
