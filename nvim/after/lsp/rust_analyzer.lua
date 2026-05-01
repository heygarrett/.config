---@type vim.lsp.Config
return {
	---@type lspconfig.settings.rust_analyzer
	settings = {
		["rust-analyzer"] = {
			cargo = {
				targetDir = true,
			},
			check = {
				command = "clippy",
				extraArgs = {
					"--",
					"--warn=clippy::todo",
				},
			},
			-- https://github.com/rust-lang/rust-analyzer/blob/master/editors/code/package.json
			inlayHints = {
				chainingHints = {
					enable = false,
				},
				closureReturnTypeHints = {
					enable = "with_block",
				},
				lifetimeElisionHints = {
					enable = "always",
					useParameterNames = false,
				},
			},
		},
	},
}
