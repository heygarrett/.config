local trouble = function()
	return require("trouble")
end

return {
	"https://github.com/folke/trouble.nvim",
	lazy = true,
	keys = {
		{
			"<leader>q",
			function()
				trouble().toggle({
					mode = "diagnostics",
					focus = true,
					filter = { buf = 0 },
				})
			end,
			mode = { "n" },
			desc = "trouble: toggle diagnostics",
		},
	},
	opts = {},
}
