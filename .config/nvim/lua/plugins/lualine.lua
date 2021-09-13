vim.opt.laststatus = 2
vim.opt.showmode = false

local function check_modified()
	if vim.opt.modified:get() == true then
		return '[+]'
	else
		return ''
	end
end

local function filepath()
	if vim.opt.filetype:get() == 'netrw' then
		return vim.fn.getcwd()
	elseif vim.fn.expand('%:p:.') ~= '' then
		return vim.fn.expand('%:p:.') .. check_modified()
	else
		return '[No Name]'
	end
end

local function round(p)
	return p % 1 >= .5 and math.ceil(p) or math.floor(p)
end

local function progress()
	local p = vim.fn.line('.') * 100 / vim.fn.line('$')
	return tostring(round(p)) .. '%%'
end

return require('lualine').setup {
	options = {
		icons_enabled = false,
		theme = 'dracula',
		component_separators = {'|', '|'},
		section_separators = {'', ''}
	},
	sections = {
		lualine_c = {filepath},
		lualine_y = {progress}
	}
}
