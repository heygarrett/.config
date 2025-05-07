return {
	---@param bufnr integer
	---@param callback fun(root_dir?: string)
	root_dir = function(bufnr, callback)
		if not vim.fs.root(bufnr, { "jsconfig.json", "tsconfig.json" }) then
			callback(vim.fs.root(bufnr, {
				"deno.json",
				"deno.jsonc",
			}) or vim.uv.cwd())
		end
	end,
	---@param client vim.lsp.Client
	---@param bufnr integer
	on_attach = function(client, bufnr)
		if not vim.fs.root(bufnr, { "deno.json", "deno.jsonc" }) then
			client.config.settings.deno =
				---@diagnostic disable-next-line: param-type-mismatch
				vim.tbl_deep_extend("force", client.config.settings.deno, {

					config = vim.fs.joinpath(vim.env.XDG_CONFIG_HOME, "deno/deno.json"),
				})
		end
	end,
}
