vim.pack.add({ "https://github.com/Wansmer/sibling-swap.nvim" })

local sibling_swap = function()
	return require("sibling-swap")
end

require("sibling-swap").setup({
	use_default_keymaps = false,
})

vim.keymap.set({ "n" }, "<leader>f", function()
	sibling_swap().swap_with_right()
end, { desc = "sibling-swap: swap forward" })
vim.keymap.set({ "n" }, "<leader>b", function()
	sibling_swap().swap_with_left()
end, { desc = "sibling-swap: swap back" })
vim.keymap.set({ "n" }, "<leader>F", function()
	sibling_swap().swap_with_right_with_opp()
end, { desc = "sibling-swap: swap forward and flip operand" })
vim.keymap.set({ "n" }, "<leader>B", function()
	sibling_swap().swap_with_left_with_opp()
end, { desc = "sibling-swap: swap back and flip operand" })
