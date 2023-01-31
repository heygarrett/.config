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
			local ignored_filetypes = setmetatable({
				"diff",
				"fish",
				"git%w+",
				"oil",
			}, {
				__index = function(tbl, key)
					for _, ft in ipairs(tbl) do
						if key:match("^" .. ft .. "$") then return true end
					end
					return false
				end,
			})
			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("mason-lspconfig", { clear = true }),
				callback = function(t)
					if ignored_filetypes[t.match] then return end
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
}
