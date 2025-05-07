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
			inlayHints = {
				-- bindingModeHints = { enable = false },
				-- chainingHints = { enable = true },
				-- closingBraceHints = {
				-- 	enable = true,
				-- 	minLines = 25,
				-- },
				-- closureCaptureHints = { enable = false },
				closureReturnTypeHints = { enable = "always" },
				-- closureStyle = "impl_fn",
				-- discriminantHints = { enable = "never" },
				-- expressionAdjustmentHints = {
				-- 	enable = "never",
				-- 	hideOutsideUnsafe = false,
				-- 	mode = "prefix",
				-- },
				-- implicitDrops = { enable = false },
				lifetimeElisionHints = {
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
