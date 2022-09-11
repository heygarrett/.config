return {
	"numToStr/FTerm.nvim",
	config = function()
		local loaded, FTerm = pcall(require, "FTerm")
		if not loaded then return end

		vim.keymap.set({ "n", "t" }, "<leader>t", function()
			if vim.opt_local.buftype:get() ~= "prompt" then
				FTerm.toggle()
				vim.cmd.checktime()
			end
		end)
	end,
}
