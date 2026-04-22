---@type vim.lsp.Config
return {
	on_attach = function(client, bufnr)
		if
			vim.fs.root(bufnr, {
				"tombi.toml",
				".tombi.toml",
				".config/tombi.toml",
			})
		then
			return
		end

		client.server_capabilities.documentFormattingProvider = false
	end,
}
