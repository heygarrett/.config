return {
	"nvim-treesitter/nvim-treesitter",
	run = [[if exists(":TSUpdate") | TSUpdate | endif]],
	config = function()
		local loaded, treesitter = pcall(require, "nvim-treesitter.configs")
		if not loaded then return end

		treesitter.setup({
			auto_install = true,
			highlight = {
				enable = true,
			},
		})
	end,
}
