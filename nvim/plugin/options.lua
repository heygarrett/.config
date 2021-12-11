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
vim.opt.listchars = { tab = '| ', lead = '·', trail = '·', eol = '$' }
vim.opt.mouse = 'a'
vim.opt.number = true
vim.opt.path:append('**')
vim.opt.scrolloff = 3
vim.opt.shortmess:append('c')
vim.opt.showmatch = true
vim.opt.showmode = false
vim.opt.smartcase = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.termguicolors = true

vim.api.nvim_command([[au FileType * setl formatoptions-=r | setl formatoptions-=o]])
