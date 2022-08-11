return {
	"numToStr/FTerm.nvim",
	config = function()
		local success, FTerm = pcall(require, "FTerm")
		if not success then return end

		vim.keymap.set({ "n", "t" }, "<leader>t", function()
			if vim.opt_local.buftype:get() ~= "prompt" then
				FTerm.toggle()
				vim.api.nvim_command("checktime")
			end
		end)
	end,
}
