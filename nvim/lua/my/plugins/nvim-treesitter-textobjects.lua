---@param submodule? string
local textobjects = function(submodule)
	local module_path = table.concat({ "nvim-treesitter-textobjects", submodule }, ".")
	return require(module_path)
end

textobjects().setup({
	select = { lookahead = true },
})

vim.keymap.set({ "x", "o" }, "al", function()
	textobjects("select").select_textobject("@loop.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "il", function()
	textobjects("select").select_textobject("@loop.inner", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "aC", function()
	textobjects("select").select_textobject("@class.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "iC", function()
	textobjects("select").select_textobject("@class.inner", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "af", function()
	textobjects("select").select_textobject("@function.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "if", function()
	textobjects("select").select_textobject("@function.inner", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ac", function()
	textobjects("select").select_textobject("@conditional.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ic", function()
	textobjects("select").select_textobject("@conditional.inner", "textobjects")
end)
