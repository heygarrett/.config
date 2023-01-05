local M = {}

M.setup = function(bufnr)
	-- user command: Format
	vim.api.nvim_buf_create_user_command(bufnr, "Format", function()
		-- Use null-ls sources when available
		vim.lsp.buf.format({
			filter = function(client)
				if client.name == "null-ls" then
					return true
				elseif package.loaded["null-ls"] then
					return #require("null-ls.sources").get_available(
						vim.bo.filetype,
						"NULL_LS_FORMATTING"
					) == 0
				else
					return true
				end
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
