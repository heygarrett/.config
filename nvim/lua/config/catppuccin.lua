return {
	"catppuccin/nvim",
	config = function()
		local success, _ = pcall(require, "catppuccin")
		if not success then return end

		vim.g.catppuccin_flavour = "mocha"
		vim.api.nvim_command("colorscheme catppuccin")
	end,
}
