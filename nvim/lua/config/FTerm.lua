return {
	"numToStr/FTerm.nvim",
	config = function()
		vim.keymap.set({ "i", "n", "t" }, "<leader>t", require("FTerm").toggle)
	end,
}
