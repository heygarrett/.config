---@type vim.lsp.Config
return {
	filetypes = {
		"css",
		"html",
		"javascript",
		"javascriptreact",
		"json",
		"jsonc",
		"less",
		"markdown",
		"sass",
		"scss",
		"typescript",
		"typescriptreact",
		"vento",
		"yaml",
	},
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
			callback(vim.uv.cwd())
			return
		end

		local config_basename = vim.fs.basename(closest_config)
		if vim.startswith(config_basename, "deno") then
			callback(vim.fs.dirname(closest_config))
		end
	end,
	on_attach = function(client, bufnr)
		if vim.fs.root(bufnr, { "deno.json", "deno.jsonc" }) then
			return
		end

		client.config.settings.deno =
			---@diagnostic disable-next-line: param-type-mismatch
			vim.tbl_deep_extend("force", client.config.settings.deno, {
				config = vim.fs.joinpath(vim.env.XDG_CONFIG_HOME, "deno/deno.json"),
			})
	end,
	---@type lspconfig.settings.denols
	settings = {
		deno = {
			inlayHints = {
				enumMemberValues = {
					enabled = true,
				},
				functionLikeReturnTypes = {
					enabled = true,
				},
				parameterNames = {
					---@type "all" | "literals" | "none"
					enabled = "all",
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
