function _G.fold_text()
	local indent_char = vim.bo.expandtab and ":" or "|"
	local indent_block = indent_char .. (" "):rep(vim.bo.tabstop - 1)
	local prefix = indent_block:rep(vim.v.foldlevel):gsub(" $", "")
	local number_of_lines = vim.v.foldend - vim.v.foldstart + 1
	local preview =
		vim.api.nvim_buf_get_lines(0, vim.v.foldstart - 1, vim.v.foldstart, true)[1]
	local stripped_preview = preview:gsub("^%s+", "")
	return table.concat(
		{ prefix, number_of_lines, "lines folded:", stripped_preview },
		" "
	)
end

vim.o.foldenable = false
vim.o.foldmethod = "indent"
vim.o.foldtext = "v:lua.fold_text()"
vim.opt.fillchars:append({ fold = " " })
