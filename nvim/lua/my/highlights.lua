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

-- clear syntax highlights
for _, group in ipairs(vim.fn.getcompletion("@", "highlight")) do
	local keeping = {
		"comment",
	}
	for _, pattern in ipairs(keeping) do
		if group:match(pattern) then
			goto continue
		end
	end

	vim.api.nvim_set_hl(0, group, {})

	::continue::
end

-- intentional syntax highlights
-- https://tonsky.me/blog/syntax-highlighting/
vim.api.nvim_set_hl(0, "Comment", {
	italic = true,
	update = true,
})
vim.api.nvim_set_hl(0, "@comment", { link = "Comment" })

vim.api.nvim_set_hl(0, "Constant", { fg = "NvimLightMagenta" })
vim.api.nvim_set_hl(0, "@boolean", { link = "Constant" })
vim.api.nvim_set_hl(0, "@character", { link = "Constant" })
vim.api.nvim_set_hl(0, "@number", { link = "Constant" })

vim.api.nvim_set_hl(0, "Declaration", { fg = "NvimLightBlue" })
vim.api.nvim_set_hl(0, "@lsp.mod.declaration", { link = "Declaration" })

vim.api.nvim_set_hl(0, "String", { fg = "NvimLightGreen" })
vim.api.nvim_set_hl(0, "@string", { link = "String" })

vim.api.nvim_set_hl(0, "Symbol", {
	fg = "NvimLightGrey3",
	update = true,
})
vim.api.nvim_set_hl(0, "@punctuation", { link = "Symbol" })
vim.api.nvim_set_hl(0, "@operator", { link = "Symbol" })

-- HTML
vim.api.nvim_set_hl(0, "@none.html", { fg = "NvimLightBlue" })
