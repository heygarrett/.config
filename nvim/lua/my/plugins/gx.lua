return {
	"https://github.com/chrishrb/gx.nvim",
	lazy = true,
	keys = {
		{
			"gx",
			function() vim.cmd.Browse() end,
			mode = { "n", "x" },
		},
	},
	dependencies = { "https://github.com/nvim-lua/plenary.nvim" },
	opts = {
		handlers = {
			search = false,
		},
	},
}
