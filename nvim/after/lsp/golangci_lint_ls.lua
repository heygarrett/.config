---@type vim.lsp.Config
return {
	init_options = {
		command = {
			"golangci-lint",
			"run",
			"--output.json.path=stdout",
			"--show-stats=false",
			"--allow-parallel-runners",
			"--enable=cyclop",
		},
	},
}
