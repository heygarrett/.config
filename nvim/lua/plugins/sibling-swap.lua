local sibling_swap = function() return require("sibling-swap") end

return {
	"Wansmer/sibling-swap.nvim",
	init = function()
		-- Swap forward and back
		vim.keymap.set("n", "<leader>f", function() sibling_swap().swap_with_right() end)
		vim.keymap.set("n", "<leader>b", function() sibling_swap().swap_with_left() end)
		-- Swap and flip operands
		vim.keymap.set(
			"n",
			"<leader>F",
			function() sibling_swap().swap_with_right_with_opp() end
		)
		vim.keymap.set(
			"n",
			"<leader>B",
			function() sibling_swap().swap_with_left_with_opp() end
		)
	end,
	config = function()
		sibling_swap().setup({
			use_default_keymaps = false,
		})
	end,
}
