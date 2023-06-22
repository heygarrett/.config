return {
	{
		"https://github.com/williamboman/mason.nvim",
		build = ":MasonUpdate",
		config = true,
	},
	{
		"https://github.com/williamboman/mason-lspconfig.nvim",
		config = function()
			local mason_lspconfig = require("mason-lspconfig")
			mason_lspconfig.setup()
			vim.api.nvim_create_autocmd("FileType", {
				desc = "Auto-install language servers for new file types",
				group = vim.api.nvim_create_augroup("mason-lspconfig", { clear = true }),
				callback = function(t)
					if t.match:match("git") then
						return
					end
					if vim.bo[t.buf].buftype ~= "" then
						return
					end
					local available_servers =
						mason_lspconfig.get_available_servers({ filetype = t.match })
					if #available_servers == 0 then
						return
					end
					local installed_servers = mason_lspconfig.get_installed_servers()
					for _, available in ipairs(available_servers) do
						for _, installed in ipairs(installed_servers) do
							if available == installed then
								return
							end
						end
					end
					---@diagnostic disable-next-line: param-type-mismatch
					vim.defer_fn(vim.cmd.LspInstall, 500)
				end,
			})
		end,
	},
	{
		"https://github.com/jay-babu/mason-null-ls.nvim",
		config = function()
			require("mason-null-ls").setup({
				automatic_installation = true,
			})
		end,
	},
}
