return {
	"https://github.com/j-hui/fidget.nvim",
	config = function()
		require("fidget").setup({
			progress = { suppress_on_insert = true },
			notification = {
				override_vim_notify = true,
				configs = {
					default = vim.tbl_extend(
						"force",
						require("fidget.notification").default_config,
						{ update_hook = false }
					),
				},
				window = {
					border = "single",
					normal_hl = "",
					winblend = 0,
					zindex = 99,
				},
			},
		})
	end,
}
