return {
	"Wansmer/sibling-swap.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	config = function()
		local loaded, sibling_swap = pcall(require, "sibling-swap")
		if not loaded then return end

		sibling_swap.setup({
			use_default_keymaps = false,
		})

		-- Swap forward and back
		vim.keymap.set("n", "<leader>f", sibling_swap.swap_with_right)
		vim.keymap.set("n", "<leader>b", sibling_swap.swap_with_left)
		-- Swap and flip operands
		vim.keymap.set("n", "<leader>F", sibling_swap.swap_with_right_with_opp)
		vim.keymap.set("n", "<leader>B", sibling_swap.swap_with_left_with_opp)
	end,
}
