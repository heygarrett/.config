return {
	'nvim-lualine/lualine.nvim',
	config = function()
		vim.opt.laststatus = 2
		vim.opt.showmode = false

		local function round(p)
			return p % 1 >= .5 and math.ceil(p) or math.floor(p)
		end

		local function progress()
			if vim.fn.line('.') == 1 then
				return 'top'
			elseif vim.fn.line('.') == vim.fn.line('$') then
				return 'bot'
			else
				local p = vim.fn.line('.') / vim.fn.line('$') * 100
				-- TODO: prepend one space to single-digit percentage
				return tostring(round(p)) .. '%%'
			end
		end

		require('lualine').setup {
			options = {
				icons_enabled = false,
				theme = 'dracula',
				component_separators = { '|', '|' },
				section_separators = { '', '' }
			},
			sections = {
				lualine_c = {
					{ 'filename', file_status = true, path = 1 }
				},
				lualine_y = { progress },
			},
		}
	end
}
