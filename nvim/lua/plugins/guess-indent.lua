return {
	"NMAC427/guess-indent.nvim",
	version = "*",
	lazy = false,
	config = function()
		require("guess-indent").setup({
			auto_cmd = false,
			filetype_exclude = {
				"diff",
				"gitcommit",
				"gitrebase",
			},
		})
	end,
}
