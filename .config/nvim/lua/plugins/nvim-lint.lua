local lint = require('lint')
lint.linters_by_ft = {
	javascript = {'eslint'},
	typescript = {'eslint'},
}
-- lint.linters.eslint.cmd = './node_modules/.bin/eslint'

vim.cmd([[autocmd BufEnter,InsertLeave * lua require('lint').try_lint()]])
vim.cmd([[command! TryLint lua require('lint').try_lint()]])
