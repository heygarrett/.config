vim.filetype.add({
	extension = {
		env = "dotenv",
		purs = "purescript",
	},
	filename = {
		Brewfile = "ruby",
		env = "dotenv",
		fish_variables = "fish",
		[".swift-format"] = "json",
	},
	pattern = {
		["^env%.[%w_-]+"] = "dotenv",
	},
})

-- use bash parser for dotenv files
vim.treesitter.language.register("bash", "dotenv")

local group = vim.api.nvim_create_augroup("filetypes", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	desc = "use jsonc for json with comments",
	group = group,
	pattern = "json",
	callback = function(filetype_event_opts)
		vim.api.nvim_create_autocmd("DiagnosticChanged", {
			desc = "use jsonc for json with comments",
			group = group,
			buffer = filetype_event_opts.buf,
			once = true,
			callback = function(diagnostic_event_opts)
				for _, diagnostic in ipairs(diagnostic_event_opts.data.diagnostics) do
					if
						diagnostic.bufnr == diagnostic_event_opts.buf
						-- Comments are not permitted in JSON. [521]
						and diagnostic.code == 521
					then
						vim.cmd.setlocal({
							args = { "filetype=jsonc" },
						})
						local jsonls_client_id = next(vim.lsp.get_clients({
							bufnr = diagnostic_event_opts.buf,
							name = "jsonls",
						}))
						if jsonls_client_id then
							vim.lsp.buf_detach_client(
								diagnostic_event_opts.buf,
								jsonls_client_id
							)
							vim.lsp.buf_attach_client(
								diagnostic_event_opts.buf,
								jsonls_client_id
							)
						end
						break
					end
				end
			end,
		})
	end,
})