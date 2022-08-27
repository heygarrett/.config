return {
	"NMAC427/guess-indent.nvim",
	config = function()
		local loaded, guess_indent = pcall(require, "guess-indent")
		if not loaded then return end

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
