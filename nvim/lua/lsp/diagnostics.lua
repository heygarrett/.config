for _, type in ipairs({ "Error", "Warn", "Hint", "Info" }) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = "", texthl = hl, numhl = hl })
	vim.cmd.highlight({
		args = {
			"DiagnosticVirtualText" .. type,
			"gui=NONE",
		},
	})
	vim.cmd.highlight({
		bang = true,
		args = {
			"link",
			"DiagnosticUnderline" .. type,
			"DiagnosticVirtualText" .. type,
		},
	})
end

vim.diagnostic.config({
	virtual_text = false,
	float = { source = "always" },
})

vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
