return {
	"prettier/vim-prettier",
	config = function()
		vim.api.nvim_create_augroup("prettier", { clear = true })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = "prettier",
			pattern = { "*.js", "*.ts" },
			command = "Prettier",
		})
	end
}
