vim.cmd.highlight({
	args = { "StatusLine", "guifg=NvimLightGrey2", "guibg=NvimDarkGrey3" },
})

vim.cmd.highlight({
	args = { "StatusLineNC", "guifg=NvimLightGrey4", "guibg=NvimDarkGrey2" },
})

-- make inlay hints more visible in merge conflicts
vim.cmd.highlight({
	args = { "DiffChange", "guifg=NvimLightGrey1", "guibg=NvimDarkGrey3" },
})
