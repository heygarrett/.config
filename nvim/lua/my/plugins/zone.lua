return {
	"https://github.com/tamton-aquib/zone.nvim",
	dev = true,
	lazy = true,
	cmd = "Zone",
	config = function()
		require("zone").setup({
			after = -1,
		})
	end,
}
