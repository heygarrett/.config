vim.keymap.set(
	"n",
	"<s-tab>",
	"<c-o>",
	{ desc = "go to older position in the jump list" }
)
vim.keymap.set("n", "j", "gj", { desc = "go down one display line" })
vim.keymap.set("n", "k", "gk", { desc = "go up to one display line" })
