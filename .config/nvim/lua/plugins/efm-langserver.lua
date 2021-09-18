local on_attach = require('utils/on_attach')

local function command_path(project, global)
	local path
	local f = io.open(project .. global, 'r')
	if f ~= nil then
		io.close(f)
		path = project .. global
	else
		path = global
	end
	return path .. ' '
end

local prettier = {
	formatCommand = command_path('./node_modules/.bin', 'prettier') .. '--stdin-filepath ${INPUT}',
	formatStdin = true,
}

local eslint = {
	lintCommand = command_path('./node_modules/.bin', 'eslint') .. '-f compact --stdin --stdin-filename ${INPUT}',
	lintIgnoreExitCode = true,
	lintStdin = true,
	lintFormats = {
		'%f: line %l, col %c, %trror - %m',
		'%f: line %l, col %c, %tarning - %m',
	}
}

local luacheck = {
	lintCommand = 'luacheck --formatter plain --codes -',
	lintIgnoreExitCode = true,
	lintStdin = true,
	lintFormats = {'%f:%l:%c: (%t%n) %m'},
}

local languages = {
	typescript = {eslint, prettier},
	javascript = {eslint, prettier},
	json = {eslint},
	lua = {luacheck},
}

require('lspconfig').efm.setup {
	init_options = {documentFormatting = true},
	filetypes = vim.tbl_keys(languages),
	settings = {
		rootMarkers = {'.git/'},
		languages = languages
	},
	on_attach = on_attach,
}
