local on_attach = function(client, bufnr)
	require("lsp.diagnostics")

	-- Use omnicomplete with LSP
	if client.supports_method("textDocument/completion") then
		require("lsp.completion").setup(bufnr)
	end

	-- Formatting user command and autocmd
	if client.supports_method("textDocument/formatting") then
		require("lsp.formatting").setup(bufnr)
	end

	-- LSP settings
	local opts = { buffer = bufnr }
	vim.keymap.set("i", "<c-s>", vim.lsp.buf.signature_help, opts)
	vim.keymap.set("n", "<leader>h", vim.lsp.buf.hover, opts)
	vim.api.nvim_buf_create_user_command(bufnr, "Def", vim.lsp.buf.definition, {})
	vim.api.nvim_buf_create_user_command(
		bufnr,
		"Actions",
		function() vim.lsp.buf.code_action() end,
		{}
	)
	vim.api.nvim_buf_create_user_command(bufnr, "Rename", function(t)
		if t.args ~= "" then
			vim.lsp.buf.rename(t.args)
		else
			local esc = vim.api.nvim_replace_termcodes("<esc>", true, true, true)
			local keys = ("q:aRename %s%s"):format(vim.fn.expand("<cword>"), esc)
			vim.api.nvim_feedkeys(keys, "in", false)
		end
	end, { nargs = "?" })
end

return on_attach
