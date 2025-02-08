local snippy = function()
	return require("snippy")
end

local group = vim.api.nvim_create_augroup("snippy", { clear = true })
vim.api.nvim_create_autocmd("CompleteDone", {
	desc = "set up nvim-snippy",
	group = group,
	callback = function()
		snippy().complete_done()
	end,
})

snippy().setup({
	mappings = {
		is = {
			["<tab>"] = "next",
			["<s-tab>"] = "previous",
		},
	},
})
