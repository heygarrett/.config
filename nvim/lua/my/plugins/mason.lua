return {
	{
		"https://github.com/williamboman/mason.nvim",
		build = function()
			vim.cmd.MasonUpdate()
		end,
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
				"biome",
				"clangd",
				"cmake",
				"eslint",
				"fourmolu",
				"goimports",
				"golangci-lint",
				"golangci_lint_ls",
				"golines",
				"gopls",
				"jsonls",
				"lua_ls",
				"marksman",
				"prettierd",
				"ruff",
				"shellcheck",
				"shfmt",
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
