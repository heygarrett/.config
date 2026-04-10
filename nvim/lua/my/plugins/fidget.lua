vim.pack.add({ "https://github.com/j-hui/fidget.nvim" })

---@param submodule? string
local fidget = function(submodule)
	local module_path = table.concat({ "fidget", submodule }, ".")
	return require(module_path)
end

fidget().setup({
	progress = {
		suppress_on_insert = true,
		ignore_done_already = true,
	},
	notification = {
		override_vim_notify = true,
		configs = {
			default = vim.tbl_extend(
				"force",
				fidget("notification").default_config,
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

vim.api.nvim_create_user_command("Notifications", function()
	fidget("notification").show_history()
end, { desc = "fidget history" })
