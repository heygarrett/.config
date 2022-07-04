return {
	"nvim-treesitter/nvim-treesitter",
	run = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup {
			ensure_installed = {
				"bash",
				"fish",
				"hjson",
				"json",
				"jsonc",
				"lua",
				"markdown",
				"markdown_inline",
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
