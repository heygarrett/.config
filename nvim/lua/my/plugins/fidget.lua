---@param submodule? string
local fidget = function(submodule)
	local module_path = table.concat({ "fidget", submodule }, ".")
	return require(module_path)
end

return {
	"https://github.com/j-hui/fidget.nvim",
	init = function()
		vim.api.nvim_create_user_command("Messages", function()
			fidget("notification").show_history()
		end, { desc = "fidget history" })
	end,
	config = function()
		fidget().setup({
			progress = { suppress_on_insert = true },
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
	end,
}
