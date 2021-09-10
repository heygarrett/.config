vim.opt.laststatus = 2
vim.opt.showmode = false

local function check_modified()
	if vim.o.modified == true then
		return '[+]'
	else
		return ''
	end
end

local function filepath()
	if vim.opt.filetype == 'netrw' then
		return vim.fn.expand('%:p:h')
	elseif vim.fn.expand('%:p:.') ~= '' then
		return vim.fn.expand('%:p:.') .. check_modified()
	else
		return '[No Name]'
	end
end

return require('lualine').setup {
	options = {
		icons_enabled = false,
		theme = 'dracula',
		component_separators = {'|', '|'},
		section_separators = {'', ''}
	},
	sections = {
		lualine_c = {filepath}
	}
}
