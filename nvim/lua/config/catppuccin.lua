return {
	"catppuccin/nvim",
	as = "catppuccin",
	config = function()
		local loaded, catppuccin = pcall(require, "catppuccin")
		if not loaded then return end

		catppuccin.setup({
			flavour = "mocha",
			no_italic = true,
		})
		vim.cmd.colorscheme({
			args = { "catppuccin" },
		})
	end,
}
