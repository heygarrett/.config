vim.opt.laststatus = 2
vim.opt.showmode = false

local function check_modified()
	if vim.opt.readonly:get() == true then
		return '[-]'
	elseif vim.opt.modified:get() == true then
		return '[+]'
	else
		return ''
	end
end

local function filepath()
	local path
	if vim.opt.filetype:get() == 'netrw' then
		path = vim.fn.getcwd()
	elseif vim.fn.expand('%:p:.') ~= '' then
		path = vim.fn.expand('%:p:.')
	else
		path = '[No Name]'
	end
	return path .. check_modified()
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
