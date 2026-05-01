---@type vim.lsp.Config
return {
	root_dir = function(bufnr, callback)
		local _, closest_config = next(vim.fs.find({
			"deno.json",
			"deno.jsonc",
			"deno.lock",
			"jsconfig.json",
			"tsconfig.json",
		}, {
			path = vim.api.nvim_buf_get_name(bufnr),
			upward = true,
			limit = 1,
			type = "file",
		}))

		if not closest_config then
			return
		end

		local config_basename = vim.fs.basename(closest_config)
		if vim.regex("^[jt]sconfig"):match_str(config_basename) then
			callback(vim.fs.dirname(closest_config))
		end
	end,
	---@type lspconfig.settings.vtsls
	settings = {
		autoUseWorkspaceTsdk = true,
		javascript = {
			format = {
				enable = false,
			},
			inlayHints = {
				functionLikeReturnTypes = {
					enabled = true,
				},
				parameterNames = {
					enabled = "all",
					suppressWhenArgumentMatchesName = true,
				},
				parameterTypes = {
					enabled = false,
				},
				propertyDeclarationTypes = {
					enabled = true,
				},
				variableTypes = {
					enabled = false,
					suppressWhenTypeMatchesName = true,
				},
			},
		},
		typescript = {
			format = {
				enable = false,
			},
			inlayHints = {
				enumMemberValues = {
					enabled = true,
				},
				functionLikeReturnTypes = {
					enabled = true,
				},
				parameterNames = {
					enabled = "all",
					suppressWhenArgumentMatchesName = true,
				},
				parameterTypes = {
					enabled = false,
				},
				propertyDeclarationTypes = {
					enabled = true,
				},
				variableTypes = {
					enabled = false,
					suppressWhenTypeMatchesName = true,
				},
			},
		},
	},
}
