---@type vim.lsp.Config
return {
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
				-- bindingModeHints = { enable = false },
				chainingHints = { enable = false },
				-- closingBraceHints = {
				-- 	enable = true,
				-- 	minLines = 25,
				-- },
				-- closureCaptureHints = { enable = false },
				closureReturnTypeHints = {
					---@type "always" | "never" | "with_block"
					enable = "with_block",
				},
				-- ---@type "impl_fn" | "rust_analyzer" | "with_id" | "hide"
				-- closureStyle = "impl_fn",
				-- discriminantHints = {
				-- 	---@type "always" | "never" | "fieldless"
				-- 	enable = "never",
				-- },
				-- expressionAdjustmentHints = {
				-- 	---@type "always" | "never" | "reborrow"
				-- 	enable = "never",
				-- 	hideOutsideUnsafe = false,
				-- 	---@type "prefix" | "postfix" | "prefer_prefix" | "prefer_postfix"
				-- 	mode = "prefix",
				-- },
				-- implicitDrops = { enable = false },
				lifetimeElisionHints = {
					---@type "always" | "never" | "skip_trivial"
					enable = "always",
					useParameterNames = false,
				},
				-- maxLength = 25,
				-- parameterHints = { enable = true },
				-- rangeExclusiveHints = { enable = false },
				-- renderColons = true,
				-- typeHints = {
				-- 	enable = true,
				-- 	hideClosureInitialization = false,
				-- 	hideNamedConstructor = false,
				-- },
			},
		},
	},
}
