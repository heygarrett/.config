vim.api.nvim_create_augroup("on_attach", { clear = true })
require("lsp.diagnostics")

local on_attach = function(client, bufnr)
	-- Use omnicomplete with LSP
	if client.supports_method("textDocument/completion") then
		require("lsp.completion").setup(bufnr)
	end

	-- Format on save
	if client.supports_method("textDocument/formatting") then
		require("lsp.formatting").setup(bufnr)
	end

	-- LSP settings
	local opts = { buffer = bufnr }
	vim.keymap.set("i", "<c-s>", vim.lsp.buf.signature_help, opts)
	vim.keymap.set("n", "<leader>h", vim.lsp.buf.hover, opts)
	vim.api.nvim_buf_create_user_command(bufnr, "Actions", vim.lsp.buf.code_action, {})
	vim.api.nvim_buf_create_user_command(bufnr, "Def", vim.lsp.buf.definition, {})
	vim.api.nvim_buf_create_user_command(bufnr, "Rename", function(t)
		if t.args ~= "" then
			vim.lsp.buf.rename(t.args)
		else
			vim.api.nvim_feedkeys(
				("q:aRename %s"):format(vim.fn.expand("<cword>")),
				"in",
				true
			)
		end
	end, { nargs = "?" })
end

return on_attach
