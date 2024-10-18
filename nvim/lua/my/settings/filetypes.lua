vim.filetype.add({
	extension = {
		env = "dotenv",
	},
	filename = {
		env = "dotenv",
	},
	pattern = {
		["^env%.[%w_-]+"] = "dotenv",
	},
})

-- use bash parser for dotenv files
vim.treesitter.language.register("bash", "dotenv")
