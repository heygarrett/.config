return {
	"https://github.com/nvim-treesitter/nvim-treesitter",
	dependencies = {
		"https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
	},
	build = function()
		vim.cmd.TSUpdate()
	end,
	opts = {
		auto_install = true,
		ensure_installed = { "comment", "markdown_inline" },
		ignore_install = { "diff", "gitcommit" },
		highlight = { enable = true },
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<leader>ss",
				node_incremental = "<leader>sm",
				node_decremental = "<leader>sr",
			},
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
	},
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
	end,
}
