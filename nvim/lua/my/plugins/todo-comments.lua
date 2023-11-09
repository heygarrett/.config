local todo_comments = function() return require("todo-comments") end

return {
	"https://github.com/folke/todo-comments.nvim",
	dependencies = "https://github.com/nvim-lua/plenary.nvim",
	init = function()
		vim.keymap.set(
			"n",
			"]t",
			function() todo_comments().jump_next() end,
			{ desc = "jump to next todo comment" }
		)
		vim.keymap.set(
			"n",
			"[t",
			function() todo_comments().jump_prev() end,
			{ desc = "jump to previous todo comment" }
		)
	end,
	config = function()
		require("todo-comments").setup({
			signs = false,
			highlight = { after = "" },
		})
	end,
}
