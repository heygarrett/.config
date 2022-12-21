return {
	"dcampos/nvim-snippy",
	config = function()
		local loaded, snippy = pcall(require, "snippy")
		if not loaded then return end

		vim.api.nvim_create_autocmd("CompleteDone", {
			group = vim.api.nvim_create_augroup("snippy", { clear = true }),
			callback = function() snippy.complete_done() end,
		})

		snippy.setup({
			mappings = {
				is = {
					["<tab>"] = "next",
					["<s-tab>"] = "previous",
				},
			},
		})
	end,
}
