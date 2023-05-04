vim.keymap.set(
	"n",
	"<s-tab>",
	"<c-o>",
	{ desc = "go to older position in the jump list" }
)
vim.keymap.set("n", "j", "gj", { desc = "go down one display line" })
vim.keymap.set("n", "k", "gk", { desc = "go up to one display line" })
vim.keymap.set("i", "<cr>", function()
	local pum_info = vim.fn.complete_info({ "mode", "selected" })
	if pum_info.mode ~= "" and pum_info.selected == -1 then
		return "<c-e><cr>"
	else
		return "<cr>"
	end
end, {
	expr = true,
	desc = "workaround for pop-up menu issue in vim",
	-- https://github.com/vim/vim/issues/1653
})

local group = vim.api.nvim_create_augroup("navigation", { clear = true })

vim.api.nvim_create_autocmd("BufEnter", {
	group = group,
	callback = function()
		if vim.fn.win_gettype() ~= "" then
			-- don't resize floating windows
			return
		end
		vim.cmd.resize()
	end,
	desc = "turn horizontal splits into a vertical accordion",
})
