return {
	"https://github.com/echasnovski/mini.pick",
	config = function()
		local pick = require("mini.pick")
		pick.setup()

		-- LSP lists
		vim.api.nvim_create_user_command("References", function()
			vim.lsp.buf.references({
				method = "textDocument/references",
				bufnr = 0,
			}, {
				on_list = function(opts)
					-- print(vim.inspect(opts.items))
					pick.start({
						source = {
							items = vim.tbl_map(
								function(item)
									return ("%s:%d:%d: %s"):format(
										vim.fn.fnamemodify(item.filename, ":."),
										item.lnum,
										item.col,
										item.text:gsub("\t", "")
									)
								end,
								opts.items
							),
							name = opts.title,
						},
					})
				end,
			})
		end, { desc = "mini.pick: LSP references" })
	end,
}
