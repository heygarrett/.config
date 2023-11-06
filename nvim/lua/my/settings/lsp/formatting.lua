local M = {}

M.setup = function(bufnr, client)
	local guess_indent_loaded, guess_indent = pcall(require, "guess-indent")

	vim.api.nvim_buf_create_user_command(bufnr, "Format", function(tbl)
		-- Run formatter
		vim.lsp.buf.format({
			filter = function(format_client)
				return (
					(format_client.name == "efm")
					== (vim.b[bufnr].efm_formatting_available or false)
				)
			end,
		})

		-- Determine indentation after formatting
		if not guess_indent_loaded then
			return
		end
		local indent = guess_indent.guess_from_buffer()

		-- Match indentation to value of expandtab
		if (indent == "tabs") == vim.bo.expandtab then
			-- Prompt for retab if formatting manually
			if tbl.args ~= "save" then
				local success, choice =
					pcall(vim.fn.confirm, "Retab?", "&Yes\n&no")
				if not success then
					return
				elseif choice == 2 then
					return
				end
			end
			-- then retab
			local preferred_tabstop = (
				vim.bo.expandtab and vim.bo.tabstop or vim.go.tabstop
			)
			if indent ~= "tabs" then
				vim.bo.tabstop = tonumber(indent)
			end
			vim.cmd.retab({
				bang = true,
			})
			vim.bo.tabstop = preferred_tabstop
			if not vim.bo.expandtab then
				vim.bo.shiftwidth = 0
			end
		end
	end, {
		nargs = "?",
		desc = "synchronous formatting",
	})

	if client.server_capabilities.documentFormattingProvider then
		local group =
			vim.api.nvim_create_augroup("formatting", { clear = false })
		vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			desc = "format on save",
			group = group,
			buffer = bufnr,
			callback = function() vim.cmd.Format({ args = { "save" } }) end,
		})
	end
end

return M
