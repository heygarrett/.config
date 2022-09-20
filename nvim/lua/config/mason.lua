return {
	"williamboman/mason.nvim",
	requires = {
		"williamboman/mason-lspconfig.nvim",
		"jayp0521/mason-null-ls.nvim",
	},
	config = function()
		local loaded_mason, mason = pcall(require, "mason")
		if not loaded_mason then return end
		mason.setup()

		local loaded_mason_lspconfig, mason_lspconfig = pcall(require, "mason-lspconfig")
		if not loaded_mason_lspconfig then return end
		mason_lspconfig.setup({
			automatic_installation = true,
		})

		local loaded_mason_null_ls, mason_null_ls = pcall(require, "mason-null-ls")
		if not loaded_mason_null_ls then return end
		mason_null_ls.setup({
			automatic_installation = true,
		})
	end,
}
