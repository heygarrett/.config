---@type vim.lsp.Config
return {
	settings = {
		yaml = {
			customTags = { "!reference sequence" },
			format = { enable = false },
			keyOrdering = false,
			schemas = {
				[".direnv/chlg-schema.json"] = "changelogs/*",
			},
			schemaStore = { enable = false },
		},
	},
}
