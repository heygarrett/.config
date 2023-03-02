local treesj = function() return require("treesj") end

return {
	"https://github.com/Wansmer/treesj",
	init = function()
		vim.api.nvim_create_user_command("Join", function() treesj().join() end, {})
		vim.api.nvim_create_user_command("Split", function() treesj().split() end, {})
	end,
	config = function()
		treesj().setup({
			use_default_keymaps = false,
		})
	end,
}
