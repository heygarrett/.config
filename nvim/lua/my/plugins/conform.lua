local formatters_by_ft = {
	fish = { "fish_indent" },
	lua = { "stylua" },
	python = { { "black" } },
	swift = { "swift_format" },
}

local format_with_prettier = {
	"css",
	"html",
	"javascript",
	"javascriptreact",
	"json",
	"jsonc",
	"markdown",
	"scss",
	"typescript",
	"typescriptreact",
	"yaml",
}

for _, ft in ipairs(format_with_prettier) do
	formatters_by_ft[ft] = { "prettierd" }
end

return {
	"https://github.com/stevearc/conform.nvim",
	lazy = true,
	config = function()
		require("conform").setup({
			formatters_by_ft = formatters_by_ft,
			formatters = {
				prettierd = {
					env = { PRETTIERD_LOCAL_PRETTIER_ONLY = 1 },
					condition = function()
						local prettierd_info = vim.fn.system(
							"PRETTIERD_LOCAL_PRETTIER_ONLY=1 prettierd --debug-info ."
						)
						return prettierd_info:find("Loaded") and true or false
					end,
				},
			},
		})
	end,
}
