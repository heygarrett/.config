return {
	"gorbit99/codewindow.nvim",
	config = function()
		local loaded, codewindow = pcall(require, "codewindow")
		if not loaded then return end

		codewindow.setup()
		vim.keymap.set("n", "<c-w>m", codewindow.toggle_minimap)
		vim.keymap.set("n", "<c-w>M", codewindow.toggle_focus)
	end,
}
