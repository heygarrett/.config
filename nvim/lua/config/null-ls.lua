return {
	"jose-elias-alvarez/null-ls.nvim",
	requires = "nvim-lua/plenary.nvim",
	config = function()
		vim.api.nvim_create_augroup("null-ls", { clear = true })
		require("null-ls").setup {
			sources = {
				require("null-ls").builtins.formatting.prettier,
			},
			on_attach = function(client, bufnr)
				-- Format on save with Prettier
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = "null-ls",
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({
								bufnr = bufnr,
								filter = function()
									return client.name == "null-ls"
								end
							})
						end,
					})
				end
			end,
		}
	end
}
