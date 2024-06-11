local M = {}

---@param bufnr number
---@param client vim.lsp.Client?
M.setup = function(bufnr, client)
	-- Exit early if this server doesn't provide completion
	if not (client and client.supports_method("textDocument/completion")) then
		return
	end

	vim.keymap.set("i", "<c-space>", "<c-x><c-o>", {
		buffer = bufnr,
		desc = "omnicompletion",
	})

	local group = vim.api.nvim_create_augroup("completion", { clear = true })
	vim.api.nvim_create_autocmd("CompleteDonePre", {
		desc = "auto-apply additional edits (eg, resolve imports)",
		group = group,
		callback = function(args)
			local complete_info = vim.fn.complete_info({ "selected" })
			if complete_info.selected == -1 then
				-- exit early if pop-up menu closes without a selected item
				-- (for some reason imports can be duplicated otherwise)
				return
			end
			local ok, completion_item = pcall(
				function()
					return vim.v.completed_item.user_data.nvim.lsp.completion_item
				end
			)
			if not ok then
				return
			end

			if
				client.server_capabilities.completionProvider.resolveProvider
			then
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
							args.buf,
							client.offset_encoding
						)
					end
				)
			elseif completion_item.additionalTextEdits then
				vim.lsp.util.apply_text_edits(
					completion_item.additionalTextEdits,
					args.buf,
					client.offset_encoding
				)
			end
		end,
	})
end

return M
