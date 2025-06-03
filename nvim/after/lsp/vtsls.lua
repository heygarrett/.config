---@type vim.lsp.Config
return {
	root_dir = function(bufnr, callback)
		local root_dir = vim.fs.root(bufnr, {
			"jsconfig.json",
			"tsconfig.json",
		})
		if root_dir then
			callback(root_dir)
		end
	end,
	on_attach = function(client)
		client.server_capabilities.documentFormattingProvider = false
	end,
	settings = {
		autoUseWorkspaceTsdk = true,
		javascript = {
			inlayHints = {
				functionLikeReturnTypes = { enabled = true },
				parameterNames = {
					---@type "all" | "literals" | "none"
					enabled = "all",
					suppressWhenArgumentMatchesName = true,
				},
				parameterTypes = { enabled = true },
				propertyDeclarationTypes = { enabled = true },
				variableTypes = {
					enabled = false,
					suppressWhenTypeMatchesName = true,
				},
			},
		},
		typescript = {
			inlayHints = {
				enumMemberValues = { enabled = true },
				functionLikeReturnTypes = { enabled = true },
				parameterNames = {
					---@type "all" | "literals" | "none"
					enabled = "all",
					suppressWhenArgumentMatchesName = true,
				},
				parameterTypes = { enabled = true },
				propertyDeclarationTypes = { enabled = true },
				variableTypes = {
					enabled = false,
					suppressWhenTypeMatchesName = true,
				},
			},
		},
	},
}
