---@param diagnostic vim.Diagnostic
---@return string?
local format_diagnostic = function(diagnostic)
	local components = { diagnostic.message }
	if
		diagnostic.source and not vim.startswith(diagnostic.message, diagnostic.source)
	then
		table.insert(components, 1, ("%s:"):format(diagnostic.source))
	end
	if diagnostic.code then
		table.insert(components, ("[%s]"):format(diagnostic.code))
	end

	return table.concat(components, " ")
end

vim.diagnostic.config({
	float = {
		format = format_diagnostic,
		suffix = "",
	},
	virtual_lines = {
		current_line = true,
		format = format_diagnostic,
	},
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.HINT] = "",
			[vim.diagnostic.severity.INFO] = "",
		},
		numhl = {
			[vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
			[vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
			[vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
			[vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
		},
	},
})
