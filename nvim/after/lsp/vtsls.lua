---@type vim.lsp.Config
return {
	settings = {
		autoUseWorkspaceTsdk = true,
		javascript = {
			format = { enable = false },
			inlayHints = {
				functionLikeReturnTypes = { enabled = true },
				parameterNames = {
					---@type "all" | "literals" | "none"
					enabled = "all",
					suppressWhenArgumentMatchesName = true,
				},
				parameterTypes = { enabled = false },
				propertyDeclarationTypes = { enabled = true },
				variableTypes = {
					enabled = false,
					suppressWhenTypeMatchesName = true,
				},
			},
		},
		typescript = {
			format = { enable = false },
			inlayHints = {
				enumMemberValues = { enabled = true },
				functionLikeReturnTypes = { enabled = true },
				parameterNames = {
					---@type "all" | "literals" | "none"
					enabled = "all",
					suppressWhenArgumentMatchesName = true,
				},
				parameterTypes = { enabled = false },
				propertyDeclarationTypes = { enabled = true },
				variableTypes = {
					enabled = false,
					suppressWhenTypeMatchesName = true,
				},
			},
		},
	},
}
