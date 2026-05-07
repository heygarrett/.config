vim.pack.add({ "https://github.com/stevearc/oil.nvim" })

local oil = function()
	return require("oil")
end

oil().setup({
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
		["<C-s>"] = {
			"actions.select",
			opts = {
				horizontal = true,
			},
		},
		["<C-v>"] = {
			"actions.select",
			opts = {
				vertical = true,
			},
		},
	},
})

vim.api.nvim_create_user_command("Ex", function()
	oil().open()
end, { desc = "open file browser" })

vim.keymap.set("n", "<leader>-", function()
	oil().open()
end, { desc = "open file browser" })
