return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = true,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			local mason_lspconfig = require("mason-lspconfig")
			mason_lspconfig.setup()
			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("mason-lspconfig", { clear = true }),
				callback = function(t)
					if vim.bo[t.buf].buftype ~= "" then return end
					local available_servers =
						mason_lspconfig.get_available_servers({ filetype = t.match })
					local installed_servers = mason_lspconfig.get_installed_servers()
					for _, available in ipairs(available_servers) do
						for _, installed in ipairs(installed_servers) do
							if available == installed then return end
						end
					end
					vim.schedule(vim.cmd.LspInstall)
				end,
			})
		end,
	},
	{
		"jay-babu/mason-null-ls.nvim",
		lazy = false,
		config = function()
			require("mason-null-ls").setup({
				automatic_installation = true,
			})
		end,
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		lazy = false,
		config = function()
			local mason_nvim_dap = require("mason-nvim-dap")
			mason_nvim_dap.setup({
				ensure_installed = { "python" },
				automatic_setup = true,
			})
			mason_nvim_dap.setup_handlers()
		end,
	},
}
