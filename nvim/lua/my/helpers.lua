local M = {}

M.get_branches = function(ArgLead)
	local all_branches = vim.fn.system({
		"git",
		"branch",
		"--all",
		"--format=%(refname:short)",
	})
	if ArgLead then
		---@type string[]
		local filtered_branches = {}
		for b in vim.gsplit(all_branches, "\n", { trimempty = true }) do
			if vim.startswith(b, ArgLead) then
				table.insert(filtered_branches, b)
			end
		end
		return filtered_branches
	else
		return vim.split(all_branches, "\n", { trimempty = true })
	end
end

return M
