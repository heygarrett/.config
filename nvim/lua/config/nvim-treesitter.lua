return {
	{
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			local loaded, _ = pcall(require, "treesitter-context")
			if not loaded then return end
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		config = function()
			local loaded, _ = pcall(require, "nvim-treesitter-textobjects")
			if not loaded then return end
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
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
				},
			})
		end,
	},
}
