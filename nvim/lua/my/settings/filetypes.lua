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
	desc = "set up watcher for comments in json files",
	group = group,
	pattern = "json",
	callback = function(filetype_event_opts)
		local diagnostic_autocommand = vim.api.nvim_create_autocmd("DiagnosticChanged", {
			desc = "watch for json comment diagnostic and change filetype to jsonc",
			group = group,
			buffer = filetype_event_opts.buf,
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
					else
						vim.diagnostic.reset(nil, diagnostic_event_opts.buf)
					end

					-- delete autocommand after resolving comment diagnostic
					return true
				end
			end,
		})
		vim.api.nvim_create_autocmd(
			{ "TextChanged", "TextChangedI", "TextChangedP", "TextChangedT" },
			{
				desc = "delete json comment diagnostic autocommand if text changes",
				group = group,
				buffer = filetype_event_opts.buf,
				once = true,
				callback = function()
					pcall(vim.api.nvim_del_autocmd, diagnostic_autocommand)
				end,
			}
		)
	end,
})
