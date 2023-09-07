return {
	"https://github.com/stevearc/oil.nvim",
	config = function()
		local oil = require("oil")
		oil.setup({
			view_options = {
				show_hidden = true,
			},
			keymaps = {
				["<C-h>"] = false,
				["<C-l>"] = false,
				["<C-r>"] = "actions.refresh",
				["<C-s>"] = "actions.select_split",
				["<C-v>"] = "actions.select_vsplit",
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
