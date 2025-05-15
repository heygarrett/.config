---@type vim.lsp.Config
return {
	settings = {
		yaml = {
			customTags = { "!reference sequence" },
			keyOrdering = false,
			schemas = {
				[".direnv/chlg-schema.json"] = "changelogs/*",
			},
			schemaStore = { enable = false },
		},
	},
}
