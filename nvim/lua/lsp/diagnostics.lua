vim.diagnostic.config({
	virtual_text = false,
	float = { source = "always" },
})

for _, type in ipairs({ "Error", "Warn", "Hint", "Info" }) do
	local hl_sign = "DiagnosticSign" .. type
	local hl_underline = "DiagnosticUnderline" .. type
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
		args = { hl_underline, "gui=underline" },
	})
end

vim.keymap.set(
	"n",
	"<leader>d",
	vim.diagnostic.open_float,
	{ desc = "show diagnostics in a floating window" }
)
vim.keymap.set(
	"n",
	"<leader>q",
	vim.diagnostic.setloclist,
	{ desc = "add buffer diagnostics to location list" }
)
vim.keymap.set(
	"n",
	"[d",
	vim.diagnostic.goto_prev,
	{ desc = "go to previous diagnostic" }
)
-- stylua: ignore
vim.keymap.set(
	"n",
	"]d",
	vim.diagnostic.goto_next,
	{ desc = "go to next diagnostic" }
)
