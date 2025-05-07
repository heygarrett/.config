return {
	---@param bufnr integer
	---@param callback fun(root_dir?: string)
	root_dir = function(bufnr, callback)
		local root_dir = vim.fs.root(bufnr, {
			"jsconfig.json",
			"tsconfig.json",
		})
		if root_dir then
			callback(root_dir)
		end
	end,
	workspace_required = true,
	init_options = {
		preferences = {
			includeInlayEnumMemberValueHints = true,
			-- includeInlayFunctionLikeReturnTypeHints = false,
			-- includeInlayFunctionParameterTypeHints = false,
			includeInlayParameterNameHints = "all",
			-- includeInlayParameterNameHintsWhenArgumentMatchesName = false,
			-- includeInlayPropertyDeclarationTypeHints = true,
			-- includeInlayVariableTypeHints = false,
			-- includeInlayVariableTypeHintsWhenTypeMatchesName = false,
		},
		-- prevent omni completion from inserting extra period
		completionDisableFilterText = true,
	},
	---@param client vim.lsp.Client
	on_attach = function(client)
		client.server_capabilities.documentFormattingProvider = false
	end,
}
