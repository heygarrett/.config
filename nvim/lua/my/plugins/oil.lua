return {
	"https://github.com/stevearc/oil.nvim",
	lazy = false,
	init = function()
		vim.api.nvim_create_user_command("Ex", function()
			require("oil").open()
		end, { desc = "Open file browser" })
	end,
	opts = {
		view_options = {
			show_hidden = true,
			---@param name string
			is_always_hidden = function(name)
				return name == ".."
			end,
		},
		keymaps = {
			["<C-h>"] = false,
			["<C-l>"] = false,
			["<C-r>"] = "actions.refresh",
			["<C-s>"] = "actions.select_split",
			["<C-v>"] = "actions.select_vsplit",
		},
	},
}
