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
