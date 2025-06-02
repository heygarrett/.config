---@type vim.lsp.Config
return {
	root_dir = function(bufnr, callback)
		local root_dir = vim.fs.root(bufnr, function(name)
			return vim.tbl_contains({
				"Package.swift",
				"%.xcodeproj$",
			}, function(marker)
				return name:match(marker) ~= nil
			end, { predicate = true })
		end)
		if root_dir then
			callback(root_dir)
		end
	end,
}
