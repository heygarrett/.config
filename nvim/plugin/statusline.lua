local function file_name()
	local pdot = vim.fn.expand('%:p:.')
	if pdot:find('^/') then
		return pdot
	elseif pdot == '' then
		return vim.fn.getcwd() .. '/'
	else
		local root_path = vim.fn.getcwd()
		local root_name = root_path:match('([^/]+)$')
		return root_name .. '/' .. pdot
	end
end

local function progress()
	if vim.fn.line('.') == 1 then
		return 'top'
	elseif vim.fn.line('.') == vim.fn.line('$') then
		return 'bot'
	else
		local p = vim.fn.line('.') / vim.fn.line('$') * 100
		p = p % 1 >= .5 and math.ceil(p) or math.floor(p)
		return string.format('%02d', p) .. '%%'
	end
end

function _G.status_line()
	return ' '
		.. vim.fn.mode()
		.. ' '
		.. '|'
		.. ' '
		.. '%<'
		.. file_name()
		.. ' '
		.. '%h'
		.. '%m'
		.. '%='
		.. '%y'
		.. ' '
		.. progress()
		.. ' '
end

vim.opt.statusline = '%{%v:lua.status_line()%}'
