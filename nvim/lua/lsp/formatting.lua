local M = {}

M.setup = function(bufnr)
	-- user command: Format
	vim.api.nvim_buf_create_user_command(bufnr, "Format", function()
		-- Use null-ls sources when available
		vim.lsp.buf.format({
			filter = function(client)
				if package.loaded["null-ls"] and client.name ~= "null-ls" then
					return #require("null-ls.sources").get_available(
						vim.bo.filetype,
						"NULL_LS_FORMATTING"
					) == 0
				else
					return true
				end
			end,
		})

		-- Retab if formatting changes the indentation type
		local guess_indent = package.loaded["guess-indent"]
		if not guess_indent then return end
		local indent = guess_indent.guess_from_buffer()
		-- xnor
		if (indent == "tabs") == vim.bo.expandtab then
			local tabstop = vim.bo.tabstop
			if indent ~= "tabs" then vim.bo.tabstop = indent end
			vim.cmd.retab({
				bang = true,
			})
			if vim.bo.tabstop ~= tabstop then vim.bo.tabstop = tabstop end
		end
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
