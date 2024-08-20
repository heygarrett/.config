local M = {}

---@param bufnr number
---@param client vim.lsp.Client
M.setup = function(bufnr, client)
	-- Exit early if this server doesn't provide completion
	if not client.supports_method("textDocument/completion") then
		return
	end

	local group = vim.api.nvim_create_augroup("completion", { clear = false })
	vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })
	vim.api.nvim_create_autocmd("CompleteDonePre", {
		desc = "auto-apply additional edits (eg, resolve imports)",
		group = group,
		buffer = bufnr,
		callback = function(event_opts)
			local complete_info = vim.fn.complete_info({ "selected" })
			if complete_info.selected == -1 then
				-- exit early if pop-up menu closes without a selected item
				-- (for some reason imports can be duplicated otherwise)
				return
			end
			local completion_item = vim.tbl_get(
				vim.v.completed_item,
				"user_data",
				"nvim",
				"lsp",
				"completion_item"
			)
			if not completion_item then
				return
			end

			if client.server_capabilities.completionProvider.resolveProvider then
				client.request(
					"completionItem/resolve",
					completion_item,
					function(err, result)
						if err then
							vim.notify_once(err.message, err.code)
							return
						end
						if not (result and result.additionalTextEdits) then
							return
						end

						vim.lsp.util.apply_text_edits(
							result.additionalTextEdits,
							event_opts.buf,
							client.offset_encoding
						)
					end
				)
			elseif completion_item.additionalTextEdits then
				vim.lsp.util.apply_text_edits(
					completion_item.additionalTextEdits,
					event_opts.buf,
					client.offset_encoding
				)
			end
		end,
	})
end

return M
