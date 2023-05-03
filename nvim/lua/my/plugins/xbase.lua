return {
	"https://github.com/kkharji/xbase",
	lazy = true,
	ft = "swift",
	config = function()
		require("lspconfig").sourcekit.setup({})
		require("xbase").setup()
	end,
}
