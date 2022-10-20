return {
	"catppuccin/nvim",
	as = "catppuccin",
	config = function()
		local loaded, catppuccin = pcall(require, "catppuccin")
		if not loaded then return end

		vim.g.catppuccin_flavour = "mocha"
		catppuccin.setup()
		vim.cmd.colorscheme({
			args = { "catppuccin" },
		})
	end,
}
