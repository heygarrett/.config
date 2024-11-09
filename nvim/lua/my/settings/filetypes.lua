vim.filetype.add({
	extension = {
		env = "dotenv",
		purs = "purescript",
	},
	filename = {
		env = "dotenv",
		[".swift-format"] = "json",
	},
	pattern = {
		["^env%.[%w_-]+"] = "dotenv",
	},
})

-- use bash parser for dotenv files
vim.treesitter.language.register("bash", "dotenv")

-- TODO: use treesitter to search for jsonc-style comments instead
local group = vim.api.nvim_create_augroup("filetypes", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	desc = "use jsonc for json with comments",
	group = group,
	pattern = "json",
	callback = function()
		if vim.fn.search([[\v%(^|\s)//]], "nw", 0, 500) ~= 0 then
			vim.cmd.setlocal({ args = { "filetype=jsonc" } })
		end
	end,
})
