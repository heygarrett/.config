return {
	"https://github.com/chrishrb/gx.nvim",
	lazy = true,
	keys = "gx",
	dependencies = { "https://github.com/nvim-lua/plenary.nvim" },
	config = function()
		require("gx").setup({
			handlers = {
				search = false,
			},
		})
	end,
}
