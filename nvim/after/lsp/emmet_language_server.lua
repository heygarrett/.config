---@type vim.lsp.Config
return {
	init_options = {
		showSuggestionsAsSnippets = true,
		syntaxProfiles = {
			html = {
				tag_nl = true,
				inline_break = 2,
			},
		},
	},
}
