vim.api.nvim_set_hl(0, "ColorColumn", {
	update = true,
	bg = "NvimDarkGrey1",
})

vim.api.nvim_set_hl(0, "DiffChange", {
	update = true,
	fg = "NvimLightGrey1",
	bg = "NvimDarkGrey3",
})

vim.api.nvim_set_hl(0, "StatusLine", {
	update = true,
	bold = true,
	fg = "NvimLightGrey3",
	bg = "NvimDarkGrey1",
})

vim.api.nvim_set_hl(0, "StatusLineNC", {
	update = true,
	fg = "NvimLightGrey4",
	bg = "NvimDarkGrey1",
})

vim.api.nvim_set_hl(0, "TabLineSel", {
	update = true,
	bg = "NvimDarkGrey1",
})

-- prevent HTML tags from changing the rendering of whitespace listchars
vim.api.nvim_set_hl(0, "NonText", {
	update = true,
	nocombine = true,
})
