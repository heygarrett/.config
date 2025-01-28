return {
	"https://github.com/NStefan002/screenkey.nvim",
	cmd = "Screenkey",
	opts = {
		win_opts = {
			-- width is 40 by default
			-- `col` is the right-most column of the floating window
			-- adding 20 helps center it
			col = math.ceil((vim.o.columns + 1) / 2) + 20,
			zindex = 99,
		},
		group_mappings = true,
		show_leader = true,
	},
}
