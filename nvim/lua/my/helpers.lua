local M = {}

M.get_branches = function(arg_lead)
	local all_branches_cmd = vim.system({
		"git",
		"branch",
		"--all",
		"--format=%(refname:short)",
	}):wait()
	if arg_lead then
		---@type string[]
		local filtered_branches = {}
		for b in vim.gsplit(all_branches_cmd.stdout, "\n", { trimempty = true }) do
			if vim.startswith(b, arg_lead) then
				table.insert(filtered_branches, b)
			end
		end
		return filtered_branches
	else
		return vim.split(all_branches_cmd.stdout, "\n", { trimempty = true })
	end
end

--- Get indentation size, returning number of spaces or 0 for tabs
---@param bufnr? integer
---@return integer
M.get_indentation_size = function(bufnr)
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
		else
			table.insert(leading_spaces, w)
		end
	end
	if tab_count >= #leading_spaces then
		return 0
	end

	table.sort(leading_spaces)

	return #leading_spaces[1]
end

return M
