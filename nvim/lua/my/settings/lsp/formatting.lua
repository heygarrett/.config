local M = {}

---@param formatter string
---@return boolean
local function find_config_file(formatter)
	local config_files = {
		stylua = "stylua.toml",
		prettier = "prettierrc",
	}

	local found_config = next(
		vim.fs.find(
			function(name) return name:match(config_files[formatter]) end,
			{ upward = true, type = "file" }
		)
	)

	return found_config and true or false
end

---@param filetype string
---@return boolean
local function efm_available(filetype)
	if filetype == "lua" then
		return find_config_file("stylua")
	elseif
		vim.tbl_contains({
			"css",
			"html",
			"javascript",
			"javascriptreact",
			"json",
			"jsonc",
			"markdown",
			"scss",
			"typescript",
			"typescriptreact",
			"yaml",
		}, filetype)
	then
		return find_config_file("prettier")
	elseif filetype == "python" then
		local xor = vim.fn.executable("black") ~= vim.fn.executable("yapf")
		return xor
	elseif vim.tbl_contains({ "fish", "swift" }, filetype) then
		return true
	else
		return false
	end
end

M.setup = function(bufnr, client)
	vim.api.nvim_buf_create_user_command(bufnr, "Format", function()
		-- Run formatter
		vim.lsp.buf.format({
			filter = function(format_client)
				return (
					(format_client.name == "efm") == efm_available(vim.bo[bufnr].filetype)
				)
			end,
		})

		-- Determine indentation after formatting
		local gi_loaded, guess_indent = pcall(require, "guess-indent")
		if not gi_loaded then
			return
		end
		local indent = guess_indent.guess_from_buffer()

		-- Match indentation to value of expandtab
		if (indent == "tabs") == vim.bo.expandtab then
			local preferred_tabstop = (
				vim.bo.expandtab and vim.bo.tabstop or vim.go.tabstop
			)
			if indent ~= "tabs" then
				vim.bo.tabstop = tonumber(indent)
			end
			vim.cmd.retab({
				bang = true,
			})
			vim.bo.tabstop = preferred_tabstop
			if not vim.bo.expandtab then
				vim.bo.shiftwidth = 0
			end
		end
	end, { desc = "synchronous formatting" })

	if client.server_capabilities.documentFormattingProvider then
		vim.api.nvim_create_augroup("formatting", { clear = false })
		vim.api.nvim_clear_autocmds({ group = "formatting", buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			desc = "format on save",
			group = "formatting",
			buffer = bufnr,
			callback = function() vim.cmd.Format() end,
		})
	end
end

return M
