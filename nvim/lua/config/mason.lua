return {
	{
		"williamboman/mason.nvim",
		as = "mason",
		config = function()
			local loaded_mason, mason = pcall(require, "mason")
			if not loaded_mason then return end

			mason.setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		as = "mason-lspconfig",
		after = "mason",
		config = function()
			local loaded, mason_lspconfig = pcall(require, "mason-lspconfig")
			if not loaded then return end

			mason_lspconfig.setup({
				automatic_installation = true,
			})
		end,
	},
	{
		"jayp0521/mason-null-ls.nvim",
		after = "null-ls",
		config = function()
			local loaded, mason_null_ls = pcall(require, "mason-null-ls")
			if not loaded then return end

			mason_null_ls.setup({
				automatic_installation = true,
			})
		end,
	},
	{
		"jayp0521/mason-nvim-dap.nvim",
		after = "mason",
		config = function()
			local loaded, mason_nvim_dap = pcall(require, "mason-nvim-dap")
			if not loaded then return end

			mason_nvim_dap.setup({
				ensure_installed = { "python" },
				automatic_setup = true,
			})
			mason_nvim_dap.setup_handlers()
		end,
	},
}
