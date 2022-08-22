return {
	"nvim-treesitter/nvim-treesitter",
	run = ":TSUpdate",
	config = function()
		local success, treesitter = pcall(require, "nvim-treesitter.configs")
		if not success then return end

		treesitter.setup({
			ensure_installed = {
				"bash",
				"fish",
				"go",
				"hjson",
				"json",
				"jsonc",
				"lua",
				"markdown",
				"markdown_inline",
				"python",
				"rust",
				"swift",
				"toml",
				"typescript",
				"vim",
			},
			auto_install = true,
			highlight = {
				enable = true,
			},
		})
	end,
}
