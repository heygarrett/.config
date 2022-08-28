vim.api.nvim_create_augroup("on_attach", { clear = true })

local on_attach = function(client, bufnr)
	-- Use omnicomplete with LSP
	if client.supports_method("textDocument/completion") then
		vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
		vim.keymap.set("i", "<c-space>", "<c-x><c-o>")
		-- https://github.com/vim/vim/issues/1653
		vim.keymap.set("i", "<cr>", function()
			if vim.fn.pumvisible() == 1 and vim.fn.complete_info()["selected"] == -1 then
				return "<c-e><cr>"
			else
				return "<cr>"
			end
		end, { expr = true })
		-- Auto-complete
		vim.api.nvim_create_autocmd("TextChangedI", {
			group = "on_attach",
			callback = function()
				if vim.opt_local.omnifunc:get() == "" then return end
				if vim.g.pum_timer then vim.fn.timer_stop(vim.g.pum_timer) end
				if
					vim.fn
						.getline(".")
						:sub(vim.fn.col(".") - 1, vim.fn.col(".") - 1)
						:match("[%w_.]")
				then
					vim.g.pum_timer = vim.fn.timer_start(400, function()
						if vim.fn.mode():match("^[^i]") then return end
						vim.api.nvim_feedkeys("", "n", true)
					end)
				end
			end,
		})
	end

	-- Format on save
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = "on_attach",
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format({
					filter = function(formatting_client)
						return
							#vim.lsp.get_active_clients({ bufnr = bufnr }) == 1
								or formatting_client.name == "null-ls"
					end,
				})
			end,
		})
	end

	-- Diagnostics
	vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float)
	vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)
	vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
	vim.keymap.set("n", "]d", vim.diagnostic.goto_next)

	-- LSP settings
	local opts = { buffer = bufnr }
	vim.api.nvim_create_user_command("Actions", vim.lsp.buf.code_action, {})
	vim.api.nvim_create_user_command("Def", vim.lsp.buf.definition, {})
	vim.api.nvim_create_user_command("Format", function()
		vim.lsp.buf.format({
			async = true,
			filter = function(formatting_client)
				return
					#vim.lsp.get_active_clients({ bufnr = bufnr }) == 1
						or formatting_client.name == "null-ls"
			end,
		})
	end, {})
	vim.api.nvim_create_user_command("Rename", function(t)
		if t.args ~= "" then
			vim.lsp.buf.rename(t.args)
		else
			vim.api.nvim_feedkeys(
				("q:aRename %s"):format(vim.fn.expand("<cword>")),
				"in",
				true
			)
		end
	end, { nargs = "?" })
	vim.keymap.set("i", "<c-s>", vim.lsp.buf.signature_help, opts)
	vim.keymap.set("n", "<leader>h", vim.lsp.buf.hover, opts)
end

return on_attach
