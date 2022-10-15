return {
	"nvim-treesitter/nvim-treesitter",
	requires = {
		"nvim-treesitter/nvim-treesitter-context",
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	run = function()
		if package.loaded["nvim-treesitter.configs"] then vim.cmd.TSUpdate() end
	end,
	config = function()
		local loaded, treesitter = pcall(require, "nvim-treesitter.configs")
		if not loaded then return end

		treesitter.setup({
			auto_install = true,
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
				swap = {
					enable = true,
					swap_next = {
						["<leader>a"] = "@parameter.inner",
					},
					swap_previous = {
						["<leader>A"] = "@parameter.inner",
					},
				},
			},
		})
	end,
}
