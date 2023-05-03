local M = {}

M.setup = function(bufnr, client)
	vim.keymap.set("i", "<c-space>", "<c-x><c-o>", {
		buffer = bufnr,
		desc = "omnicompletion",
	})

	vim.keymap.set("i", "<cr>", function()
		local pum_info = vim.fn.complete_info({ "mode", "selected" })
		if pum_info.mode ~= "" and pum_info.selected == -1 then
			return "<c-e><cr>"
		else
			return "<cr>"
		end
	end, {
		expr = true,
		desc = "workaround for pop-up menu issue in vim",
		-- https://github.com/vim/vim/issues/1653
	})

	-- Exit early if this server doesn't provide completion
	local completion_provider = client.server_capabilities.completionProvider
	if not completion_provider then
		return
	end

	vim.api.nvim_create_augroup("completion", { clear = false })
	vim.api.nvim_clear_autocmds({ group = "completion", buffer = bufnr })
	vim.api.nvim_create_autocmd("TextChangedI", {
		desc = "auto-completion",
		group = "completion",
		buffer = bufnr,
		callback = function()
			if vim.fn.pumvisible() ~= 0 then
				return
			end
			if vim.g.pum_timer then
				vim.fn.timer_stop(vim.g.pum_timer)
			end

			local current_line = vim.api.nvim_get_current_line()
			local cursor_position = vim.api.nvim_win_get_cursor(0)[2]
			local text_before_cursor = current_line:sub(1, cursor_position)
			local trigger_characters = table.concat(completion_provider.triggerCharacters)
			local trigger_pattern = ("[%%w%s]$"):format(trigger_characters)
			if text_before_cursor:match(trigger_pattern) then
				vim.g.pum_timer = vim.fn.timer_start(300, function()
					if vim.api.nvim_get_mode().mode:match("^[^i]") then
						return
					end
					vim.api.nvim_feedkeys(
						vim.api.nvim_eval([["\<c-x>\<c-o>"]]),
						"n",
						false
					)
				end)
			end
		end,
	})
end

return M
