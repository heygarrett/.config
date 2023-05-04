return {
	"https://github.com/numToStr/FTerm.nvim",
	lazy = true,
	init = function()
		vim.keymap.set("n", "<leader>t", function()
			if vim.bo.buftype ~= "prompt" then
				require("FTerm").toggle()
				vim.cmd.checktime()
			end
		end, { desc = "toggle FTerm" })
	end,
}
