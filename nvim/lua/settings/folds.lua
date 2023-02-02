function _G.fold_text()
	local number_of_lines = vim.v.foldend - vim.v.foldstart + 1
	local indent_char = vim.bo.expandtab and ":" or "|"
	local indent_block = indent_char .. (" "):rep(vim.bo.tabstop - 1)
	local prefix = indent_block:rep(vim.v.foldlevel):gsub(" $", "")
	return table.concat({ prefix, number_of_lines, "lines folded" }, " ")
end

vim.o.foldmethod = "indent"
vim.o.foldtext = "v:lua.fold_text()"

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("folds", { clear = true }),
	callback = function()
		if vim.bo.buftype ~= "" then
			vim.wo.foldenable = false
		end
	end,
})
