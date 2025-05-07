return {
	"https://github.com/neovim/nvim-lspconfig",
	lazy = false,
	branch = "master",
	config = function()
		---@type string[]
		local configured_servers = {}
		for _, file in ipairs(vim.api.nvim_get_runtime_file("after/lsp/*.lua", true)) do
			local server_name = vim.fn.fnamemodify(file, ":t:r")
			table.insert(configured_servers, server_name)
		end
		vim.lsp.enable(configured_servers)
	end,
}
