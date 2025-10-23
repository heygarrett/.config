local codesettings = function()
	return require("codesettings")
end

return {
	"https://github.com/mrjones2014/codesettings.nvim",
	init = function()
		vim.lsp.config("*", {
			before_init = function(_, config)
				config = codesettings().with_local_settings(config.name, config)
			end,
		})
	end,
}
