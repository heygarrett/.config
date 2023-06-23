return {
	"https://github.com/stevearc/oil.nvim",
	enabled = false,
	config = function()
		require("oil").setup({
			view_options = {
				show_hidden = true,
			},
			keymaps = {
				["<C-r>"] = "actions.refresh",
				["<C-l>"] = false,

				["<C-v>"] = "actions.select_vsplit",
				["<C-s>"] = false,

				["<C-x>"] = "actions.select_split",
				["<C-h>"] = false,
			},
		})
	end,
}
