---@type vim.lsp.Config
return {
	-- HACK: https://github.com/tamasfe/taplo/issues/580#issuecomment-2361679688
	root_dir = function(_, callback)
		callback(vim.uv.cwd())
	end,
	on_attach = function(client, bufnr)
		if vim.fs.root(bufnr, {
			"taplo.toml",
			".taplo.toml",
		}) then
			return
		end

		client.server_capabilities.documentFormattingProvider = false
	end,
}
