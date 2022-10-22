vim.diagnostic.config({
	virtual_text = false,
	float = { source = "always" },
})

for _, type in ipairs({ "Error", "Warn", "Hint", "Info" }) do
	local hl_sign = "DiagnosticSign" .. type
	local hl_underline = "DiagnosticUnderline" .. type
	local hl_virtual_text = "DiagnosticVirtualText" .. type
	-- Sign column highlighting
	vim.cmd.sign({
		args = { "undefine", hl_sign },
		mods = { emsg_silent = true },
	})
	vim.cmd.sign({
		args = { "define", hl_sign, "numhl=" .. hl_sign },
	})
	-- Text highlighting
	vim.cmd.highlight({
		args = { hl_virtual_text, "gui=underline" },
	})
	vim.cmd.highlight({
		bang = true,
		args = { "link", hl_underline, hl_virtual_text },
	})
end

vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
