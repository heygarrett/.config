vim.diagnostic.config({
	virtual_text = false,
	float = {
		source = true,
		border = "single",
	},
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

vim.api.nvim_create_user_command("Diagnostics", function()
	local ok, choice = pcall(vim.fn.confirm, "", "&Document\n&workspace")
	if not ok then
		return
	elseif choice == 1 then
		vim.diagnostic.setloclist()
	elseif choice == 2 then
		vim.diagnostic.setqflist()
	end
end, { desc = "add buffer diagonstics to location list" })
