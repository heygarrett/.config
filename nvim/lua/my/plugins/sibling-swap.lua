local sibling_swap = function() return require("sibling-swap") end

return {
	"https://github.com/Wansmer/sibling-swap.nvim",
	lazy = true,
	init = function()
		-- Swap forward and back
		vim.keymap.set(
			"n",
			"<leader>f",
			function() sibling_swap().swap_with_right() end,
			{ desc = "sibling-swap: move item to the right" }
		)
		vim.keymap.set(
			"n",
			"<leader>b",
			function() sibling_swap().swap_with_left() end,
			{ desc = "sibling-swap: move item to the left" }
		)
		-- Swap and flip operands
		vim.keymap.set(
			"n",
			"<leader>F",
			function() sibling_swap().swap_with_right_with_opp() end,
			{ desc = "sibling-swap: move item to the right and update operator" }
		)
		vim.keymap.set(
			"n",
			"<leader>B",
			function() sibling_swap().swap_with_left_with_opp() end,
			{ desc = "sibling-swap: move item to the left and update operator" }
		)
	end,
	config = function()
		sibling_swap().setup({
			use_default_keymaps = false,
		})
	end,
}
