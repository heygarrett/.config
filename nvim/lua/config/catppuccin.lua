return {
	"catppuccin/nvim",
	config = function()
		vim.g.catppuccin_flavour = "mocha"
		vim.api.nvim_command("colorscheme catppuccin")
	end
}
