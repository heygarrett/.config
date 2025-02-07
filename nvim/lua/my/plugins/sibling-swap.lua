local sibling_swap = function()
	return require("sibling-swap")
end

return {
	"https://github.com/Wansmer/sibling-swap.nvim",
	keys = {
		-- Swap forward and back
		{
			"<leader>f",
			function()
				sibling_swap().swap_with_right()
			end,
			mode = { "n" },
		},
		{
			"<leader>b",
			function()
				sibling_swap().swap_with_left()
			end,
			mode = { "n" },
		},
		-- Swap and flip operands
		{
			"<leader>F",
			function()
				sibling_swap().swap_with_right_with_opp()
			end,
			mode = { "n" },
		},
		{
			"<leader>B",
			function()
				sibling_swap().swap_with_left_with_opp()
			end,
			mode = { "n" },
		},
	},
	opts = { use_default_keymaps = false },
}
