return {
	"https://github.com/stevearc/oil.nvim",
	opts = {
		view_options = {
			show_hidden = true,
			is_always_hidden = function(name) return name == ".." end,
		},
		keymaps = {
			["<C-h>"] = false,
			["<C-l>"] = false,
			["<C-r>"] = "actions.refresh",
			["<C-s>"] = "actions.select_split",
			["<C-v>"] = "actions.select_vsplit",
		},
	},
	config = function(_, opts)
		local oil = require("oil")
		oil.setup(opts)
		vim.cmd.delcommand("Oil")
		vim.api.nvim_create_user_command(
			"Ex",
			function() oil.open() end,
			{ desc = "Open file browser" }
		)
	end,
}
