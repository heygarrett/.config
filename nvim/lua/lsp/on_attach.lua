local utils = require("settings.utils")

local on_attach = function(client, bufnr)
	-- Disable formatting for servers conflicting with null-ls
	local disable_formatting = {
		sumneko_lua = true,
		jsonls = true,
		tsserver = true,
	}
	if disable_formatting[client.name] then
		client.resolved_capabilities.document_formatting = false
	end

	-- Use omnicomplete with LSP
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
	vim.api.nvim_create_autocmd("InsertCharPre", {
		group = vim.api.nvim_create_augroup("on_attach", { clear = true }),
		callback = function()
			if not utils.launched_by_user() then return end
			if vim.opt_local.omnifunc:get() == "" then return end
			if vim.fn.pumvisible() == 0 and vim.v.char:match("[%w_.]") then
				vim.api.nvim_feedkeys(
					vim.api.nvim_replace_termcodes("<c-x><c-o>", true, false, true),
					"n",
					false
				)
			end
		end,
	})

	-- Diagnostics
	vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float)
	vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)
	vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
	vim.keymap.set("n", "]d", vim.diagnostic.goto_next)

	-- LSP settings
	local opts = { buffer = bufnr }
	vim.api.nvim_create_user_command("Actions", vim.lsp.buf.code_action, {})
	vim.api.nvim_create_user_command("Def", vim.lsp.buf.definition, {})
	vim.api.nvim_create_user_command("Format", vim.lsp.buf.formatting, {})
	vim.api.nvim_create_user_command(
		"Rename",
		function(t) vim.lsp.buf.rename(t.args) end,
		{ nargs = 1 }
	)
	vim.keymap.set("i", "<c-s>", vim.lsp.buf.signature_help, opts)
	vim.keymap.set("n", "<leader>h", vim.lsp.buf.hover, opts)
end

return on_attach
