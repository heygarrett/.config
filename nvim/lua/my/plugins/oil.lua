return {
	"https://github.com/stevearc/oil.nvim",
	config = function()
		local oil = require("oil")
		oil.setup({
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

		vim.cmd.delcommand("Oil")
		vim.api.nvim_create_user_command(
			"Ex",
			function() oil.open() end,
			{ desc = "Open file browser" }
		)
	end,
}
