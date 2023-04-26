vim.keymap.set(
	"n",
	"<s-tab>",
	"<c-o>",
	{ desc = "go to older position in the jump list" }
)
vim.keymap.set("n", "j", "gj", { desc = "go down one display line" })
vim.keymap.set("n", "k", "gk", { desc = "go up to one display line" })

local group = vim.api.nvim_create_augroup("navigation", { clear = true })

vim.api.nvim_create_autocmd("WinEnter", {
	group = group,
	callback = function()
		if vim.api.nvim_win_get_config(0).relative ~= "" then
			-- don't resize floating windows
			return
		end
		vim.cmd.resize()
	end,
	desc = "turn horizontal splits into a vertical accordion",
})
