return {
	"gorbit99/codewindow.nvim",
	config = function()
		local loaded, codewindow = pcall(require, "codewindow")
		if not loaded then return end

		codewindow.setup()
		codewindow.apply_default_keybinds()
	end,
}
