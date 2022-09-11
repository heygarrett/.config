return {
	"numToStr/FTerm.nvim",
	config = function()
		local loaded, FTerm = pcall(require, "FTerm")
		if not loaded then return end

		vim.keymap.set({ "n", "t" }, "<leader>t", function()
			if vim.opt_local.buftype:get() ~= "prompt" then
				FTerm.toggle()
				vim.api.nvim_cmd({ cmd = "checktime" }, { output = false })
			end
		end)
	end,
}
