return {
	"nvim-treesitter/nvim-treesitter",
	run = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup {
			ensure_installed = {
				"fish",
				"hjson",
				"json",
				"lua",
				"markdown",
				"python",
				"rust",
				"swift",
				"typescript",
				"vim",
			},
			highlight = {
				enable = true
			}
		}
	end
}
