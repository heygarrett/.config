return {
	"https://github.com/chrishrb/gx.nvim",
	dependencies = { "https://github.com/nvim-lua/plenary.nvim" },
	lazy = true,
	keys = {
		{
			"gx",
			function() vim.cmd.Browse() end,
			mode = { "n", "x" },
		},
	},
	opts = {
		handlers = {
			search = false,
		},
	},
}
