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
	status = {
		format = function(counts)
			if #counts == 0 or vim.api.nvim_get_mode().mode:match("^i") then
				return ""
			end

			---@type string[]
			local formattedSevCounts = vim.iter(pairs(counts))
				:map(
					---@param severity integer
					---@param count integer
					function(severity, count)
						return table.concat({
							"%#DiagnosticSign",
							({ "Error", "Warn", "Info", "Hint" })[severity],
							"#",
							count,
							"%*",
						})
					end
				)
				:totable()

			return table.concat(formattedSevCounts, " ")
		end,
	},
})
