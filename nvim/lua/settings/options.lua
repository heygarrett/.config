vim.g.mapleader = " "
vim.g.netrw_banner = 0
vim.o.breakindent = true
vim.o.colorcolumn = "90"
vim.o.confirm = true
vim.o.cursorline = true
vim.o.foldmethod = "manual"
vim.o.ignorecase = true
vim.o.keywordprg = ":vertical help"
vim.o.linebreak = true
vim.o.list = true
vim.o.mouse = "a"
vim.o.number = true
vim.o.scrolloff = 3
vim.o.showmatch = true
vim.o.smartcase = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.termguicolors = true
vim.o.updatetime = 2000
vim.opt.clipboard:append("unnamedplus")
vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.path:append("**")
vim.opt.shortmess:append("Scs")

vim.api.nvim_create_augroup("options", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
	group = "options",
	callback = function()
		-- Restore cursor position
		local exclude = { diff = true, gitcommit = true, gitrebase = true }
		local position_line = vim.api.nvim_buf_get_mark(0, [["]])[1]
		if
			not exclude[vim.bo.filetype]
			and position_line >= 1
			and position_line <= vim.api.nvim_buf_line_count(0)
		then
			vim.cmd.normal({
				bang = true,
				args = { [[g`"]] },
			})
		end
	end,
})

vim.api.nvim_create_autocmd("CursorHold", {
	group = "options",
	callback = function()
		vim.cmd.checktime({
			mods = { emsg_silent = true },
		})
	end,
})

vim.api.nvim_create_autocmd("VimResized", {
	group = "options",
	callback = function()
		local mode = vim.api.nvim_get_mode().mode
		if vim.startswith(mode, "i") then
			vim.api.nvim_feedkeys(vim.api.nvim_eval([["\<esc>"]]), "n", false)
		end
		if not vim.startswith(mode, "t") then
			vim.api.nvim_feedkeys(vim.api.nvim_eval([["\<c-w>="]]), "n", false)
		end
	end,
})
