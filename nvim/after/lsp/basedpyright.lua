---@type vim.lsp.Config
return {
	---@type lspconfig.settings.basedpyright
	settings = {
		basedpyright = {
			analysis = {
				diagnosticMode = "workspace",
				diagnosticSeverityOverrides = {
					reportImplicitStringConcatenation = false,
					reportMissingParameterType = false,
				},
			},
		},
	},
}
