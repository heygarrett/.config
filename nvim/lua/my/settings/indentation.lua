-- Default to tabs
vim.o.expandtab = false
vim.o.shiftwidth = 0
vim.o.softtabstop = 0
vim.o.tabstop = 4
vim.opt.listchars = { nbsp = "_", space = "·", tab = "| " }
-- don't run editorconfig automatically
vim.g.editorconfig = false

---@param bufnr? integer
---@return integer -- number of spaces or 0 for tabs
local get_indentation_size = function(bufnr)
	bufnr = bufnr or 0

	local last_line = math.min(vim.api.nvim_buf_line_count(bufnr), 1000)

	---@type string[]
	local leading_whitespace = {}
	for _, line in ipairs(vim.api.nvim_buf_get_lines(bufnr, 0, last_line, true)) do
		table.insert(leading_whitespace, line:match("^%s+"))
	end

	if vim.tbl_isempty(leading_whitespace) then
		return 0
	end

	local tab_count = 0
	---@type string[]
	local leading_spaces = {}
	for _, w in ipairs(leading_whitespace) do
		if w:find("\t") then
			tab_count = tab_count + 1
		elseif #w > 1 then -- ignore single-space indents
			table.insert(leading_spaces, w)
		end
	end
	if tab_count >= #leading_spaces then
		return 0
	end

	table.sort(leading_spaces)

	return #leading_spaces[1]
end

local group = vim.api.nvim_create_augroup("indentation", { clear = true })
vim.api.nvim_create_autocmd("BufWinEnter", {
	desc = "indentation settings",
	group = group,
	callback = function(event_opts)
		-- override expandtab set by ftplugins
		vim.bo.expandtab = vim.go.expandtab

		if vim.bo.filetype ~= "gitcommit" then
			-- detect indentation
			local detected_indent = get_indentation_size(event_opts.buf)
			if detected_indent ~= 0 then
				vim.bo.expandtab = true
				vim.bo.tabstop = detected_indent
			end

			-- load editorconfig
			require("editorconfig").config(event_opts.buf)
		end

		-- finalize listchars
		vim.cmd.Relist()

		-- define Retab user command
		vim.api.nvim_buf_create_user_command(
			event_opts.buf,
			"Retab",
			function(command_opts)
				local current_indent = get_indentation_size(event_opts.buf)
				if (current_indent ~= 0) == vim.bo.expandtab then
					return
				end

				-- prompt for retab if formatting manually
				if command_opts.bang then
					local success, choice = pcall(
						vim.fn.confirm,
						"Overwrite formatter indentation?",
						"&Yes\n&no"
					)
					if not success then
						return
					elseif choice == 2 then
						return
					end
				end
				-- then retab
				local preferred_tabstop = (
					vim.bo.expandtab and vim.bo.tabstop or vim.go.tabstop
				)
				if current_indent ~= 0 then
					vim.bo.tabstop = current_indent
				end
				vim.cmd.retab({
					bang = true,
					range = { command_opts.line1, command_opts.line2 },
				})
				vim.bo.tabstop = preferred_tabstop
				if vim.bo.expandtab then
					vim.bo.shiftwidth = preferred_tabstop
				else
					vim.bo.shiftwidth = 0
				end
			end,
			{
				bang = true,
				range = "%",
				desc = "custom retab",
			}
		)
	end,
})

vim.api.nvim_create_user_command("Relist", function()
	if vim.bo.expandtab then
		-- set whitespace characters for indentation with spaces
		local listchars = vim.opt_global.listchars:get()
		listchars.tab = "> "
		if vim.bo.filetype ~= "markdown" then
			listchars.leadmultispace = ":" .. (" "):rep(vim.fn.shiftwidth() - 1)
		end
		vim.opt_local.listchars = listchars
	else
		-- remove leadmultispace from listchars
		vim.wo.listchars = vim.go.listchars
		-- override tabstop if we're using tabs
		vim.bo.tabstop = vim.go.tabstop
		-- reset shiftwidth
		vim.bo.shiftwidth = vim.go.shiftwidth
	end
	-- keep softtabstop turned off
	vim.bo.softtabstop = vim.go.softtabstop
end, { desc = "re-set listchars" })
