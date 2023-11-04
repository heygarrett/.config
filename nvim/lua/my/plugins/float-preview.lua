return {
	"https://github.com/ncm2/float-preview.nvim",
	lazy = true,
	event = "CompleteChanged",
	config = function() vim.g["float_preview#docked"] = 0 end,
}
