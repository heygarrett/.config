return {
	-- "NMAC427/guess-indent.nvim",
	"heygarrett/guess-indent.nvim",
	branch = "auto_cmd-argument",
	config = function()
		require("guess-indent").setup {
			auto_cmd = false,
			filetype_exclude = {
				"diff",
				"gitcommit",
			},
		}
	end
}
