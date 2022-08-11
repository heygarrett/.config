return {
	"NMAC427/guess-indent.nvim",
	config = function()
		local success, guess_indent = pcall(require, "guess-indent")
		if not success then return end

		guess_indent.setup({
			auto_cmd = false,
			filetype_exclude = {
				"diff",
				"gitcommit",
				"gitrebase",
			},
		})
	end,
}
