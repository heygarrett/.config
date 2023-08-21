return {
	"https://github.com/hrsh7th/nvim-cmp",
	lazy = true,
	event = "LspAttach",
	dependencies = {
		"https://github.com/hrsh7th/cmp-nvim-lsp",
		"https://github.com/hrsh7th/cmp-buffer",
		"https://github.com/hrsh7th/cmp-path",
		"https://github.com/dcampos/cmp-snippy",
	},
	config = function()
		local cmp = require("cmp")
		cmp.setup({
			view = { entries = "native" },
			preselect = cmp.PreselectMode.None,
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "snippy" },
			}, {
				{ name = "buffer" },
			}),
			snippet = {
				expand = function(args) require("snippy").expand_snippet(args.body) end,
			},
			mapping = cmp.mapping.preset.insert({
				["<c-f>"] = cmp.mapping.scroll_docs(4),
				["<c-b>"] = cmp.mapping.scroll_docs(-4),
				["<c-y>"] = cmp.mapping.confirm({ select = true }),
			}),
		})
	end,
}
