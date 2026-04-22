vim.pack.add({ "https://github.com/mason-org/mason.nvim" })
require("mason").setup({
	PATH = "append",
})

vim.pack.add({ "https://github.com/mason-org/mason-lspconfig.nvim" })
require("mason-lspconfig").setup({
	automatic_enable = true,
})

vim.pack.add({ "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" })
require("mason-tool-installer").setup({
	ensure_installed = {
		"actionlint",
		"basedpyright",
		"bashls",
		"biome",
		"clangd",
		"cmake",
		"commitlint",
		"eslint",
		"fish_lsp",
		"fourmolu",
		"golangci-lint",
		"golangci_lint_ls",
		"gopls",
		"html",
		"htmlhint",
		"jsonls",
		"just-lsp",
		"lua_ls",
		"marksman",
		"oxlint",
		"pkl-lsp",
		"prettierd",
		"ruff",
		"shellcheck",
		"shfmt",
		"stylua",
		"tombi",
		"vimls",
		"vtsls",
		"yamlls",
	},
})
