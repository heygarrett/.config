return {
	"https://github.com/NMAC427/guess-indent.nvim",
	lazy = true,
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
