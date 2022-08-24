return {
	"jose-elias-alvarez/null-ls.nvim",
	requires = "nvim-lua/plenary.nvim",
	config = function()
		local success, null_ls = pcall(require, "null-ls")
		if not success then return end

		null_ls.setup({
			sources = {
				null_ls.builtins.code_actions.eslint_d,
				null_ls.builtins.diagnostics.eslint_d,
				null_ls.builtins.diagnostics.fish,
				null_ls.builtins.formatting.prettierd,
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.diagnostics.editorconfig_checker.with({
					command = "editorconfig-checker",
				}),
			},
			on_attach = require("lsp.on_attach"),
		})
	end,
}
