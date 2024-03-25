local todo_comments = function() return require("todo-comments") end

return {
	"https://github.com/folke/todo-comments.nvim",
	dependencies = "https://github.com/nvim-lua/plenary.nvim",
	lazy = false,
	keys = {
		{
			"]t",
			function() todo_comments().jump_next() end,
			mode = { "n" },
		},
		{
			"[t",
			function() todo_comments().jump_prev() end,
			mode = { "n" },
		},
	},
	opts = {
		signs = false,
		highlight = { after = "" },
	},
}
