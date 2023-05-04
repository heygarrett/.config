local M = {}

M.setup = function(bufnr, client)
	-- Determine availability of null-ls formatting
	local null_ls_formatting_available = false
	local sources_loaded, null_ls_sources = pcall(require, "null-ls.sources")
	if sources_loaded then
		local null_ls_formatting_sources =
			null_ls_sources.get_available(vim.bo.filetype, "NULL_LS_FORMATTING")
		null_ls_formatting_available = #null_ls_formatting_sources ~= 0
	end

	-- Exit early if client is null-ls xor null-ls sources are available
	if (client.name == "null-ls") ~= null_ls_formatting_available then
		return
	end

	vim.api.nvim_buf_create_user_command(bufnr, "Format", function()
		vim.lsp.buf.format()

		-- Determine indentation after formatting
		local gi_loaded, guess_indent = pcall(require, "guess-indent")
		if not gi_loaded then
			return
		end
		local indent = guess_indent.guess_from_buffer()

		-- Match indentation to value of expandtab
		---@diagnostic disable: undefined-field
		if (indent == "tabs") == vim.bo.expandtab then
			local preferred_tabstop = (
				vim.bo.expandtab and vim.bo.tabstop or vim.go.tabstop
			)
			---@diagnostic enable: undefined-field
			if indent ~= "tabs" then
				vim.bo.tabstop = tonumber(indent)
			end
			vim.cmd.retab({
				bang = true,
			})
			vim.bo.tabstop = preferred_tabstop
		end
	end, { desc = "synchronous formatting" })

	if client.server_capabilities.documentFormattingProvider then
		vim.api.nvim_create_augroup("formatting", { clear = false })
		vim.api.nvim_clear_autocmds({ group = "formatting", buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			desc = "format on save",
			group = "formatting",
			buffer = bufnr,
			callback = function() vim.cmd.Format() end,
		})
	end
end

return M
