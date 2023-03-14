local M = {}

M.setup = function(bufnr)
	vim.api.nvim_buf_create_user_command(bufnr, "Format", function()
		vim.lsp.buf.format({
			filter = function(client)
				-- Use null-ls sources when available
				if package.loaded["null-ls"] and client.name ~= "null-ls" then
					local null_ls_source_count =
						#require("null-ls.sources").get_available(
							vim.bo.filetype,
							"NULL_LS_FORMATTING"
						)
					return null_ls_source_count == 0
				else
					return true
				end
			end,
		})

		-- Retab if indentation type changes when formatting
		local loaded, guess_indent = pcall(require, "guess-indent")
		if not loaded then
			return
		end
		local indent = guess_indent.guess_from_buffer()
		-- xnor
		if (indent == "tabs") == vim.bo.expandtab then
			local tabstop = vim.bo.tabstop
			if indent ~= "tabs" and vim.bo.tabstop ~= indent then
				vim.bo.tabstop = indent
			end
			vim.cmd.retab({
				bang = true,
			})
			if vim.bo.tabstop ~= tabstop then
				vim.bo.tabstop = tabstop
			end
		end
	end, { desc = "synchronous formatting" })

	vim.api.nvim_create_augroup("formatting", { clear = false })
	vim.api.nvim_clear_autocmds({ group = "formatting", buffer = bufnr })
	vim.api.nvim_create_autocmd("BufWritePre", {
		desc = "format on save",
		group = "formatting",
		buffer = bufnr,
		callback = function() vim.cmd.Format() end,
	})
end

return M
