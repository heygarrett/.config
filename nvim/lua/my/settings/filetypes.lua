vim.filetype.add({
	extension = {
		env = "dotenv",
	},
	filename = {
		Brewfile = "ruby",
		env = "dotenv",
		fish_variables = "fish",
		[".swift-format"] = "json",
	},
	pattern = {
		["env%..*"] = "dotenv",
		[".*%.env%..*"] = "dotenv",
		["%.envrc.*"] = "sh",
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
				local matching_diagnostic = vim.iter(
					diagnostic_event_opts.data.diagnostics
				)
					:find(function(diagnostic)
						return diagnostic.bufnr == diagnostic_event_opts.buf
							-- Comments are not permitted in JSON. [521]
							and diagnostic.code == 521
					end)

				if matching_diagnostic then
					vim.bo.filetype = "jsonc"

					local _, jsonls_client = next(vim.lsp.get_clients({
						bufnr = diagnostic_event_opts.buf,
						name = "jsonls",
					}))
					if jsonls_client then
						vim.lsp.buf_detach_client(
							diagnostic_event_opts.buf,
							jsonls_client.id
						)
						vim.lsp.buf_attach_client(
							diagnostic_event_opts.buf,
							jsonls_client.id
						)
					end
				end
			end,
		})
	end,
})
