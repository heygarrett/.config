---@type vim.lsp.Config
return {
	settings = {
		basedpyright = {
			analysis = {
				diagnosticSeverityOverrides = {
					reportImplicitStringConcatenation = false,
					reportMissingParameterType = false,
				},
			},
		},
	},
}
