local lspconfig = require("lspconfig")
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.resolveSupport = {
	properties = { "additionalTextEdits" },
}

lspconfig["denols"].setup({
	capabilities = capabilities,
	root_dir = function(file)
		return vim.fs.root(file, { "deno.json", "deno.jsonc" })
	end,
})
lspconfig["hls"].setup({
	capabilities = capabilities,
	on_attach = function(client)
		client.server_capabilities.documentFormattingProvider = false
	end,
})
lspconfig["rust_analyzer"].setup({
	capabilities = capabilities,
	settings = {
		["rust-analyzer"] = {
			cargo = { targetDir = true },
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
})
lspconfig["sourcekit"].setup({
	capabilities = capabilities,
	root_dir = function(file)
		return vim.fs.root(file, {
			"Package.swift",
			"*.xcodeproj",
		})
	end,
})
