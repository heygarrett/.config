vim.g.netrw_banner = 0
vim.opt.breakindent = true
vim.opt.clipboard:append("unnamedplus")
vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.confirm = true
vim.opt.cursorline = true
vim.opt.foldenable = false
vim.opt.foldmethod = "indent"
vim.opt.ignorecase = true
vim.opt.keywordprg = ":help"
vim.opt.linebreak = true
vim.opt.list = true
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.path:append("**")
vim.opt.scrolloff = 3
vim.opt.shortmess:append("Scs")
vim.opt.showmatch = true
vim.opt.smartcase = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.termguicolors = true
vim.opt.updatetime = 2000

vim.api.nvim_create_augroup("options", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	group = "options",
	callback = function()
		-- Disable automatic comments
		vim.opt.formatoptions:remove({ "r", "o" })
		-- Restore cursor position
		local exclude = { diff = true, gitcommit = true, gitrebase = true }
		if
			not exclude[vim.opt_local.filetype:get()]
			and vim.fn.line("'\"") > 1
			and vim.fn.line("'\"") <= vim.fn.line("$")
		then
			vim.api.nvim_command([[execute 'normal! g`"']])
		end
	end,
})
vim.api.nvim_create_autocmd("CursorHold", {
	group = "options",
	command = "silent! checktime",
})
