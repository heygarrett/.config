if vim.fn.isdirectory(vim.env.HOME .. '/.local/src/dracula_pro/themes/vim') > 0 then
	return {
		'~/.local/src/dracula_pro/themes/vim',
		config = function()
			vim.cmd([[colorscheme dracula_pro]])
		end
	}
else
	return {
		'dracula/vim',
		config = function()
			vim.cmd([[colorscheme dracula]])
		end
	}
end
