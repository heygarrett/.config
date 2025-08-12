local treesitter = function()
	return require("nvim-treesitter")
end

return {
	{
		"https://github.com/nvim-treesitter/nvim-treesitter",
		lazy = false,
		branch = "main",
		build = function()
			vim.cmd.TSUpdate()
		end,
		init = function()
			if not vim.tbl_contains(treesitter().get_installed(), "comment") then
				treesitter().install("comment")
			end

			local group = vim.api.nvim_create_augroup("treesitter", { clear = true })
			vim.api.nvim_create_autocmd("FileType", {
				desc = "enable treesitter",
				group = group,
				callback = function(event_opts)
					local buf_parser = vim.treesitter.language.get_lang(event_opts.match)
					if not buf_parser then
						return
					end

					local ignore_install = { "diff", "make" }
					if vim.tbl_contains(ignore_install, buf_parser) then
						return
					end

					-- TODO: find a way to wait for the parser to install
					-- before enabling treesitter
					if vim.treesitter.language.add(buf_parser) then
						vim.treesitter.start(event_opts.buf, buf_parser)
					else
						if vim.tbl_contains(treesitter().get_available(), buf_parser) then
							treesitter().install(buf_parser)
						end
					end
				end,
			})
		end,
	},
	{
		"https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		init = function()
			local keymaps = {
				["al"] = "@loop.outer",
				["il"] = "@loop.inner",
				["aC"] = "@class.outer",
				["iC"] = "@class.inner",
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@conditional.outer",
				["ic"] = "@conditional.inner",
			}

			for keys, caputure_group in pairs(keymaps) do
				vim.keymap.set({ "x", "o" }, keys, function()
					require("nvim-treesitter-textobjects.select").select_textobject(
						caputure_group,
						"textobjects"
					)
				end)
			end
		end,
		opts = {
			select = {
				lookahead = true,
			},
		},
	},
}
