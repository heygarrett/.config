return {
	'Darazaki/indent-o-matic',
	config = function()
		require('indent-o-matic').setup {
			standard_widths = {2, 4},
			filetype_markdown = {
				standard_widths = {2, 3, 4},
			},
		}
	end
}
