local lint = require('lint')
lint.linters_by_ft = {
	javascript = {'eslint'},
	typescript = {'eslint'},
}
lint.linters.eslint.cmd = './node_modules/.bin/eslint'
