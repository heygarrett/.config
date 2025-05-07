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

		-- set up remaining language servers installed with Mason
		require("mason-lspconfig").setup_handlers({
			function(server_name)
				if vim.tbl_contains(configured_servers, server_name) then
					return
				end

				vim.lsp.enable(server_name)
			end,
		})
	end,
}
