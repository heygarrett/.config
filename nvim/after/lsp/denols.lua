---@type vim.lsp.Config
return {
	filetypes = {
		"css",
		"html",
		"javascript",
		"javascript.jsx",
		"javascriptreact",
		"json",
		"jsonc",
		"less",
		"markdown",
		"typescript",
		"typescript.tsx",
		"typescriptreact",
		"sass",
		"scss",
		"vento",
		"yaml",
	},
	root_dir = function(bufnr, callback)
		if vim.fs.root(bufnr, { "jsconfig.json", "tsconfig.json" }) then
			return
		end

		callback(vim.fs.root(bufnr, {
			"deno.json",
			"deno.jsonc",
		}) or vim.uv.cwd())
	end,
	on_attach = function(client, bufnr)
		if vim.fs.root(bufnr, { "biome.json", "biome.jsonc" }) then
			client.server_capabilities.documentFormattingProvider = false
		end

		if vim.fs.root(bufnr, { "deno.json", "deno.jsonc" }) then
			return
		end

		client.config.settings.deno =
			---@diagnostic disable-next-line: param-type-mismatch
			vim.tbl_deep_extend("force", client.config.settings.deno, {
				config = vim.fs.joinpath(vim.env.XDG_CONFIG_HOME, "deno/deno.json"),
			})
	end,
	settings = {
		deno = {
			inlayHints = {
				enumMemberValues = { enabled = true },
				functionLikeReturnTypes = { enabled = true },
				parameterNames = {
					---@type "all" | "literals" | "none"
					enabled = "all",
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
