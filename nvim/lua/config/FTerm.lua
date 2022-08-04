return {
	"numToStr/FTerm.nvim",
	config = function()
		vim.keymap.set({ "n", "t" }, "<leader>t", function()
			if vim.opt_local.buftype:get() ~= "prompt" then
				require("FTerm").toggle()
				vim.api.nvim_command("checktime")
			end
		end)
	end,
}
