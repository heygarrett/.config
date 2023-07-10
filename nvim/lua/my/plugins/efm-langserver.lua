local prettier = {
	formatCommand = "prettierd ${INPUT}",
	formatStdin = true,
	env = {
		"PRETTIERD_LOCAL_PRETTIER_ONLY=1",
	},
}

local languages = {
	css = { prettier },
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
	html = { prettier },
	javascript = { prettier },
	javascriptreact = { prettier },
	json = { prettier },
	jsonc = { prettier },
	lua = {
		{
			formatCommand = "stylua --search-parent-directories -",
			formatStdin = true,
		},
	},
	python = {
		{
			formatCommand = "yapf --quiet",
			formatStdin = true,
		},
	},
	scss = { prettier },
	swift = {
		{
			formatCommand = "swift-format",
			formatStdin = true,
		},
	},
	typescript = { prettier },
	typescriptreact = { prettier },
	yaml = { prettier },
}

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
