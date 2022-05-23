vim.g.netrw_banner = 0
vim.g.python3_host_prog = vim.env.HOME .. '/.local/venvs/nvim/bin/python'
vim.opt.breakindent = true
vim.opt.clipboard:append('unnamedplus')
vim.opt.completeopt = { 'menuone', 'noselect' }
vim.opt.confirm = true
vim.opt.cursorline = true
vim.opt.ignorecase = true
vim.opt.keywordprg = ':help'
vim.opt.linebreak = true
vim.opt.list = true
vim.opt.listchars = { tab = '| ', lead = '·', trail = '·' }
vim.opt.mouse = 'a'
vim.opt.number = true
vim.opt.path:append('**')
vim.opt.scrolloff = 3
vim.opt.shortmess:append('c')
vim.opt.showmatch = true
vim.opt.smartcase = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.termguicolors = true

-- Disable automatic comments
vim.api.nvim_create_autocmd('FileType', {
	callback = function()
		vim.opt.formatoptions:remove({ 'r', 'o' })
	end
})

-- Restore cursor position
vim.api.nvim_create_autocmd('FileType', {
	callback = function()
		if vim.opt.filetype:get() ~= "gitcommit"
		and vim.fn.line("'\"") > 1
		and vim.fn.line("'\"") <= vim.fn.line("$")
		then
			vim.cmd([[exe 'normal! g`"']])
		end
	end
})
