return {
	"https://github.com/tamton-aquib/zone.nvim",
	lazy = true,
	cmd = "Zone",
	config = function()
		require("zone").setup({
			after = -1,
		})
	end,
}
