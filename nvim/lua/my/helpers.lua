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

return M
