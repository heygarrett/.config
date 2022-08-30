local M = {}

local function formatting_conditions(client, bufnr)
	return #vim.lsp.get_active_clients({ bufnr = bufnr }) == 1 or client.name == "null-ls"
end

M.setup = function(bufnr)
	-- User command
	vim.api.nvim_buf_create_user_command(bufnr, "Format", function()
		vim.lsp.buf.format({
			async = true,
			filter = function(client) return formatting_conditions(client, bufnr) end,
		})
	end, {})
	-- Format on save
	vim.api.nvim_create_autocmd("BufWritePre", {
		group = "on_attach",
		buffer = bufnr,
		callback = function()
			vim.lsp.buf.format({
				filter = function(client) return formatting_conditions(client, bufnr) end,
			})
		end,
	})
end

return M
