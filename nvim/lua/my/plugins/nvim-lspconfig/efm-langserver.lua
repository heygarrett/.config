local M = {}

M.languages = {
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

M.format_with_prettier = {
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

for _, ft in ipairs(M.format_with_prettier) do
	M.languages[ft] = {
		{
			formatCommand = "prettierd ${INPUT}",
			formatStdin = true,
			env = {
				"PRETTIERD_LOCAL_PRETTIER_ONLY=1",
			},
		},
	}
end

M.on_attach = function(_, bufnr)
	if vim.tbl_contains(M.format_with_prettier, vim.bo[bufnr].filetype) then
		local prettierd_debug_info =
			vim.fn.system("PRETTIERD_LOCAL_PRETTIER_ONLY=1 prettierd --debug-info .")
		if prettierd_debug_info:find("Loaded") then
			vim.b[bufnr].efm_formatting_available = true
		end
	elseif vim.bo[bufnr].filetype == "lua" then
		local found_stylua = vim.fn.executable("stylua") == 1
		local found_stylua_toml = not vim.tbl_isempty(
			vim.fs.find(
				function(name) return name:match("stylua.toml") end,
				{ upward = true, type = "file" }
			)
		)
		vim.b[bufnr].efm_formatting_available = (found_stylua and found_stylua_toml)
	elseif vim.bo[bufnr].filetype == "python" then
		local xor = vim.fn.executable("black") ~= vim.fn.executable("yapf")
		vim.b[bufnr].efm_formatting_available = xor
	elseif vim.tbl_contains({ "fish", "swift" }, vim.bo[bufnr].filetype) then
		vim.b[bufnr].efm_formatting_available = true
	end
end

return M
