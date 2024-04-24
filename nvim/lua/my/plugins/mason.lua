return {
	{
		"https://github.com/williamboman/mason.nvim",
		build = function() vim.cmd.MasonUpdate() end,
		opts = { PATH = "append" },
	},
	{
		"https://github.com/williamboman/mason-lspconfig.nvim",
		config = true,
	},
}
