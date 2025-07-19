---@type vim.lsp.Config
return {
	root_dir = function(bufnr, callback)
		local biome_root = vim.fs.root(bufnr, {
			"biome.json",
			"biome.jsonc",
		})
		if biome_root then
			local node_root = vim.fs.root(bufnr, {
				"package.json",
				"node_modules",
			})
			callback(node_root or biome_root)
		end
	end,
}
