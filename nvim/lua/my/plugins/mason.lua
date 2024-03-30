return {
	{
		"https://github.com/williamboman/mason.nvim",
		build = ":MasonUpdate",
		opts = { PATH = "append" },
	},
	{
		"https://github.com/williamboman/mason-lspconfig.nvim",
		config = true,
	},
}
