local languages = {
	fish = {
		{
			-- TODO: Figure out why linting doesn't work
			--
			-- lintCommand = "fish --no-execute",
			-- lintStdin = false,
			-- lintStderr = true,
			-- lintFormats = { "%f (line %l): %m" },
			--
			formatCommand = "fish_indent",
			formatStdin = true,
		},
	},
	lua = {
		{
			formatCommand = "stylua --search-parent-directories -",
			formatStdin = true,
		},
	},
	python = {
		{
			formatCommand = "black --quiet -",
			formatStdin = true,
		},
		{
			formatCommand = "yapf --quiet",
			formatStdin = true,
		},
	},
	swift = {
		{
			formatCommand = "swift-format",
			formatStdin = true,
		},
	},
}

for _, ft in ipairs({
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
}) do
	languages[ft] = {
		{
			formatCommand = "prettierd ${INPUT}",
			formatStdin = true,
			env = {
				"PRETTIERD_LOCAL_PRETTIER_ONLY=1",
			},
		},
	}
end

return {
	"https://github.com/mattn/efm-langserver",
	config = function()
		require("lspconfig").efm.setup({
			filetypes = vim.tbl_keys(languages),
			init_options = { documentFormatting = true },
			settings = {
				rootMarkers = { vim.loop.cwd() },
				languages = languages,
			},
		})
	end,
}
