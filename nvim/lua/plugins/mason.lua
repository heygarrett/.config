return {
	{
		"williamboman/mason.nvim",
		version = "*",
		lazy = false,
		config = true,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		version = "*",
		lazy = false,
		config = function()
			require("mason-lspconfig").setup({
				automatic_installation = true,
			})
		end,
	},
	{
		"jay-babu/mason-null-ls.nvim",
		version = "*",
		lazy = false,
		config = function()
			require("mason-null-ls").setup({
				automatic_installation = true,
			})
		end,
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		version = "*",
		lazy = false,
		config = function()
			local mason_nvim_dap = require("mason-nvim-dap")
			mason_nvim_dap.setup({
				ensure_installed = { "python" },
				automatic_setup = true,
			})
			mason_nvim_dap.setup_handlers()
		end,
	},
}
