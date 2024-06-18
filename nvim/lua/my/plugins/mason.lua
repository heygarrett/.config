return {
	{
		"https://github.com/williamboman/mason.nvim",
		build = function() vim.cmd.MasonUpdate() end,
		opts = { PATH = "append" },
	},
	{
		"https://github.com/williamboman/mason-lspconfig.nvim",
		opts = {},
	},
	{
		"https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = {
			ensure_installed = {
				"basedpyright",
				"bashls",
				"clangd",
				"cmake",
				"eslint",
				"goimports",
				"golangci-lint",
				"golangci_lint_ls",
				"gopls",
				"jsonls",
				"lua_ls",
				"marksman",
				"prettierd",
				"ruff",
				"rust_analyzer",
				"stylua",
				"taplo",
				"tsserver",
				"vimls",
				"yamlfmt",
				"yamlls",
			},
		},
	},
}
