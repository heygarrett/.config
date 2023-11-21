return {
	"https://github.com/nvim-treesitter/nvim-treesitter",
	dependencies = {
		"https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
	},
	build = function() vim.cmd.TSUpdate() end,
	config = function()
		require("nvim-treesitter.configs").setup({
			auto_install = true,
			ensure_installed = { "markdown_inline" },
			ignore_install = { "diff", "gitcommit" },
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
