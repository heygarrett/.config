local M = {}

M.setup = function(bufnr)
	-- user command: Format
	vim.api.nvim_buf_create_user_command(bufnr, "Format", function()
		-- Disable formatting for specific servers
		vim.lsp.buf.format({
			filter = function(client)
				local disabled_for = {
					jsonls = true,
					sumneko_lua = true,
					tsserver = true,
				}
				return not disabled_for[client.name]
			end,
		})
		-- Retab after formatting
		vim.bo.tabstop = 2
		vim.cmd.retab({
			bang = true,
		})
		vim.bo.tabstop = vim.go.tabstop
	end, {})

	-- autocmd: Format on save
	vim.api.nvim_create_augroup("formatting", { clear = false })
	vim.api.nvim_clear_autocmds({ group = "formatting", buffer = bufnr })
	vim.api.nvim_create_autocmd("BufWritePre", {
		group = "formatting",
		buffer = bufnr,
		callback = function() vim.cmd.Format() end,
	})
end

return M
