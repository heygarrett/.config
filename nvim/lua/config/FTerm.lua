return {
	"numToStr/FTerm.nvim",
	config = function()
		local loaded, FTerm = pcall(require, "FTerm")
		if not loaded then return end

		vim.keymap.set("n", "<leader>t", function()
			if vim.bo.buftype ~= "prompt" then
				FTerm.toggle()
				vim.cmd.checktime()
			end
		end)
	end,
}
