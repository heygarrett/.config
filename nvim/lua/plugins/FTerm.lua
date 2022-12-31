return {
	"numToStr/FTerm.nvim",
	init = function()
		vim.keymap.set("n", "<leader>t", function()
			if vim.bo.buftype ~= "prompt" then
				require("FTerm").toggle()
				vim.cmd.checktime()
			end
		end)
	end,
}
