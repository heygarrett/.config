---@type vim.lsp.Config
return {
	---@type lspconfig.settings.yamlls
	settings = {
		yaml = {
			format = {
				enable = false,
			},
			keyOrdering = false,
			schemaStore = {
				enable = false,
			},
		},
	},
}
