return {
	"nvim-treesitter/nvim-treesitter",
	version = "*",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-context",
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	build = function() vim.cmd.TSUpdate() end,
	lazy = false,
	config = function()
		require("nvim-treesitter.configs").setup({
			auto_install = true,
			ignore_install = { "gitcommit" },
			highlight = {
				enable = true,
				disable = { "make" },
			},
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["al"] = "@loop.outer",
						["il"] = "@loop.inner",
						["aC"] = "@class.outer",
						["iC"] = "@class.inner",
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@conditional.outer",
						["ic"] = "@conditional.inner",
					},
				},
			},
		})
	end,
}
