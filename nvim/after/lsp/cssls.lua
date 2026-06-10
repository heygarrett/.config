---@type vim.lsp.Config
return {
	on_attach = function(client)
		client.server_capabilities.documentFormattingProvider = false
		-- after choosing a CSS property completion item the language server calls this
		-- command, trying to trigger completion again for the property value
		vim.lsp.commands["editor.action.triggerSuggest"] = function()
			vim.lsp.completion.get()
		end
	end,
}
