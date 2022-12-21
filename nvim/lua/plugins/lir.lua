return {
	"tamago324/lir.nvim",
	config = function()
		local loaded, lir = pcall(require, "lir")
		if not loaded then return end

		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		local actions = require("lir.actions")
		lir.setup({
			show_hidden_files = true,
			mappings = {
				["<cr>"] = actions.edit,
				["-"] = actions.up,
				["d"] = actions.mkdir,
				["D"] = actions.wipeout,
				["%"] = actions.newfile,
				["R"] = function() actions.rename(false) end,
				["r"] = actions.reload,
			},
		})

		vim.api.nvim_create_user_command("Lir", function()
			local directory = vim.fn.expand("%:p:h")
			vim.cmd.edit({
				args = { directory },
			})
		end, {})
	end,
}
