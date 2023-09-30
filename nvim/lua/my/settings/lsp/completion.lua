local M = {}

M.setup = function(bufnr, client)
	-- Exit early if this server doesn't provide completion
	if not client.supports_method("textDocument/completion") then
		return
	end

	vim.keymap.set("i", "<c-space>", "<c-x><c-o>", {
		buffer = bufnr,
		desc = "omnicompletion",
	})

	local group = vim.api.nvim_create_augroup("completion", { clear = true })
	vim.api.nvim_create_autocmd("CompleteDone", {
		desc = "auto-apply additional edits (eg, resolve imports)",
		group = group,
		callback = function()
			local success, additional_text_edits = pcall(
				function()
					return vim.v.completed_item.user_data.nvim.lsp.completion_item.additionalTextEdits
				end
			)
			if not (success and additional_text_edits) then
				return
			end
			vim.lsp.util.apply_text_edits(
				additional_text_edits,
				bufnr,
				client.offset_encoding
			)
		end,
	})
end

return M
