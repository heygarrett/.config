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

local function calculate_colorcolumn()
	-- Number of windows in current tab
	local tab_windows = vim.fn.tabpagewinnr(vim.fn.tabpagenr(), "$")
	local win_width = vim.fn.winwidth(0)
	-- Find center column
	local center = tab_windows == 1 and math.ceil(win_width / 2) or win_width
	-- Get size of signcolumn if defined
	local sign_col = vim.opt.signcolumn:get():match("%d+")
	-- signcolumn can't be less than 2
	sign_col = sign_col and math.max(sign_col, 2) or 0
	-- Get width of largest line number
	local num_width =
		math.max(vim.opt.numberwidth:get(), tostring(vim.fn.line("$")):len() + 1)
	-- Account for the gutter difference
	local cc_pos = center - (sign_col + num_width)

	return tostring(cc_pos)
end

vim.api.nvim_create_augroup("options", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	group = "options",
	callback = function()
		-- Enable centered colorcolumn if buffer is modifiable
		if vim.opt.modifiable:get() then vim.opt.colorcolumn = calculate_colorcolumn() end
		if not vim.opt.modifiable:get() then vim.opt.colorcolumn = "" end
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
