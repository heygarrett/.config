vim.api.nvim_create_augroup("on_attach", { clear = true })

local on_attach = function(client, bufnr)
	-- Use omnicomplete with LSP
	if client.supports_method("textDocument/completion") then
		require("lsp.completion").setup(bufnr)
	end

	-- Format on save
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = "on_attach",
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format({
					filter = function(formatting_client)
						return
							#vim.lsp.get_active_clients({ bufnr = bufnr }) == 1
								or formatting_client.name == "null-ls"
					end,
				})
			end,
		})
	end

	-- Diagnostics
	vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float)
	vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)
	vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
	vim.keymap.set("n", "]d", vim.diagnostic.goto_next)

	-- LSP settings
	local opts = { buffer = bufnr }
	vim.api.nvim_create_user_command("Actions", vim.lsp.buf.code_action, {})
	vim.api.nvim_create_user_command("Def", vim.lsp.buf.definition, {})
	vim.api.nvim_create_user_command("Format", function()
		vim.lsp.buf.format({
			async = true,
			filter = function(formatting_client)
				return
					#vim.lsp.get_active_clients({ bufnr = bufnr }) == 1
						or formatting_client.name == "null-ls"
			end,
		})
	end, {})
	vim.api.nvim_create_user_command("Rename", function(t)
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
	vim.keymap.set("i", "<c-s>", vim.lsp.buf.signature_help, opts)
	vim.keymap.set("n", "<leader>h", vim.lsp.buf.hover, opts)
end

return on_attach
