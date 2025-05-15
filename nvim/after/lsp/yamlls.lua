return {
	settings = {
		yaml = {
			customTags = { "!reference sequence" },
			keyOrdering = false,
			schemas = {
				[".direnv/chlg-schema.json"] = "changelogs/*",
			},
		},
	},
}
