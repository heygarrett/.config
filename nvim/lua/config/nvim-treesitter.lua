return {
	"nvim-treesitter/nvim-treesitter",
	run = [[if exists(":TSUpdate") | TSUpdate | endif]],
	config = function()
		local loaded, treesitter = pcall(require, "nvim-treesitter.configs")
		if not loaded then return end

		treesitter.setup({
			ensure_installed = {
				"bash",
				"dockerfile",
				"fish",
				"go",
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
				"yaml",
			},
			auto_install = true,
			highlight = {
				enable = true,
			},
		})
	end,
}
