local M = {}

M.setup = function(bufnr)
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
		buffer = bufnr,
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

return M
