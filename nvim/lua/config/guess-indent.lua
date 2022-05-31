return {
	"NMAC427/guess-indent.nvim",
	config = function()
		require("guess-indent").setup {
			filetype_exclude = {
				"gitcommit"
			}
		}
	end
}
