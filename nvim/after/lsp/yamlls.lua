---@type vim.lsp.Config
return {
	settings = {
		yaml = {
			customTags = { "!reference sequence" },
			format = { enable = false },
			keyOrdering = false,
			schemaStore = { enable = false },
		},
	},
}
