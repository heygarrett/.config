return {
	"https://github.com/NMAC427/guess-indent.nvim",
	lazy = true,
	opts = {
		auto_cmd = false,
		override_editorconfig = true,
		filetype_exclude = {
			"diff",
			"gitcommit",
			"gitrebase",
		},
	},
}
