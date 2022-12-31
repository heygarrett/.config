return {
	"tamago324/lir.nvim",
	dir = "~/repos/forks/lir.nvim",
	lazy = false,
	init = function()
		vim.api.nvim_create_user_command("Lir", function()
			require("lir")
			vim.cmd.edit({
				args = { vim.fn.expand("%:p:h") },
			})
		end, {})
	end,
	config = function()
		local actions = require("lir.actions")
		require("lir").setup({
			show_hidden_files = true,
			hide_cursor = true,
			mappings = {
				-- navigation
				["-"] = actions.up,
				["<cr>"] = actions.edit,
				["<c-v>"] = function() actions.vsplit(false) end,
				-- modification
				["<c-d>"] = actions.mkdir,
				["%"] = actions.newfile,
				["R"] = function() actions.rename(false) end,
				["D"] = actions.wipeout,
				-- miscellaneous
				["<c-r>"] = actions.reload,
			},
		})
	end,
}
