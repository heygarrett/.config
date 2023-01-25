local M = {}

M.setup = function(bufnr)
	-- user command: Format
	vim.api.nvim_buf_create_user_command(bufnr, "Format", function()
		-- Watch for changes when formatting
		local pre_format_changed_tick = vim.api.nvim_buf_get_changedtick(bufnr)
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
		-- Retab after formatting iff changes were made
		local post_format_changed_tick = vim.api.nvim_buf_get_changedtick(bufnr)
		if post_format_changed_tick ~= pre_format_changed_tick then
			vim.bo.tabstop = 2
			vim.cmd.retab({
				bang = true,
			})
			---@diagnostic disable-next-line: undefined-field
			vim.bo.tabstop = vim.go.tabstop
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
