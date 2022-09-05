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
vim.api.nvim_create_autocmd("CursorHold", {
	group = "options",
	command = "silent! checktime",
})
vim.api.nvim_create_autocmd("FileType", {
	group = "options",
	callback = function()
		-- Enable colorcolumn in middle of window
		-- (accounts for wide gutters in large files)
		local gutter_diff = tostring(vim.fn.line("$")):len() - 3
		local column_number = gutter_diff > 0 and 97 - gutter_diff or 97
		if vim.opt.modifiable:get() then vim.opt.colorcolumn = tostring(column_number) end
		if not vim.opt.modifiable:get() then vim.opt.colorcolumn = "0" end
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
