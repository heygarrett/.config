local M = {}

local function formatting_conditions(client)
	local disabled_for = {
		jsonls = true,
		sumneko_lua = true,
		tsserver = true,
	}
	return not disabled_for[client.name]
end

M.setup = function(bufnr)
	-- User command
	vim.api.nvim_buf_create_user_command(bufnr, "Format", function()
		vim.lsp.buf.format({
			async = true,
			filter = function(client) return formatting_conditions(client) end,
		})
	end, {})
	-- Format on save
	vim.api.nvim_create_augroup("formatting", { clear = false })
	vim.api.nvim_clear_autocmds({ group = "formatting", buffer = bufnr })
	vim.api.nvim_create_autocmd("BufWritePre", {
		group = "formatting",
		buffer = bufnr,
		callback = function()
			vim.lsp.buf.format({
				filter = function(client) return formatting_conditions(client) end,
			})
		end,
	})
end

return M
