vim.api.nvim_set_keymap("n", "<leader>td", "<cmd>Trouble lsp_document_diagnostics<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>tw", "<cmd>Trouble lsp_workspace_diagnostics<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>gd", "<cmd>Trouble lsp_definitions<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>gr", "<cmd>Trouble lsp_references<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>gi", "<cmd>Trouble lsp_implementations<cr>",
  {silent = true, noremap = true}
)

return require("trouble").setup {
	icons = false,
	use_lsp_diagnostic_signs = true
}
