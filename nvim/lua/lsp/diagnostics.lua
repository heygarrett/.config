for _, type in ipairs({ "Error", "Warn", "Hint", "Info" }) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = "", texthl = hl, numhl = hl })
	vim.api.nvim_set_hl(
		0,
		"DiagnosticUnderline" .. type,
		vim.api.nvim_get_hl_by_name("DiagnosticVirtualText" .. type, {})
	)
	vim.cmd.highlight({ "DiagnosticUnderline" .. type, "gui=NONE" })
end

vim.diagnostic.config({
	virtual_text = false,
	float = { source = "always" },
})

vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
