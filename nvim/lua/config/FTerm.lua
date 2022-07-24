return {
	"numToStr/FTerm.nvim",
	config = function()
		vim.keymap.set({ "i", "n", "t" }, "<leader>t", function()
			require("FTerm").toggle()
			vim.api.nvim_command("checktime")
		end)
	end,
}
