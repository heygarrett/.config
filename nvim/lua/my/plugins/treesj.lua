local treesj = function()
	return require("treesj")
end

treesj().setup({ use_default_keymaps = false })

vim.api.nvim_create_user_command("Join", function()
	treesj().join()
end, { desc = "treesj: join elements into one line" })
vim.api.nvim_create_user_command("Split", function()
	treesj().split()
end, { desc = "treesj: split elements onto separate lines" })
