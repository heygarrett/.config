return {
	"jose-elias-alvarez/null-ls.nvim",
	requires = "nvim-lua/plenary.nvim",
	config = function()
		local loaded, null_ls = pcall(require, "null-ls")
		if not loaded then return end

		null_ls.setup({
			debug = false,
			sources = {
				null_ls.builtins.code_actions.eslint_d,
				null_ls.builtins.diagnostics.eslint_d,
				null_ls.builtins.diagnostics.fish,
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.prettierd.with({
					env = { PRETTIERD_LOCAL_PRETTIER_ONLY = true },
				}),
			},
			on_attach = require("lsp.on_attach"),
		})
	end,
}
