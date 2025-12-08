---@type vim.lsp.Config
return {
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
