local function filepath()
	if vim.o.filetype == 'netrw' then
		return vim.fn.getcwd()
	elseif vim.fn.expand('%:F') ~= '' then
		return vim.fn.expand('%:F') .. ' ' .. vim.fn.expand('%m')
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
