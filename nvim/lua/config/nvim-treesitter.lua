return {
	"nvim-treesitter/nvim-treesitter",
	requires = {
		"nvim-treesitter/nvim-treesitter-context",
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	run = [[if exists(":TSUpdate") | TSUpdate | endif]],
	config = function()
		local loaded, treesitter = pcall(require, "nvim-treesitter.configs")
		if not loaded then return end

		treesitter.setup({
			auto_install = true,
			highlight = { enable = true },
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
						["af"] = "@function.outer",
						["if"] = "@function.inner",
					},
				},
			},
		})
	end,
}
