vim.diagnostic.config({
	float = { source = true },
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
	virtual_lines = {
		current_line = true,
		format = function(diagnostic)
			local components = { diagnostic.message }
			if
				diagnostic.source
				and not vim.startswith(diagnostic.message, diagnostic.source)
			then
				table.insert(components, 1, ("%s:"):format(diagnostic.source))
			end
			if diagnostic.code then
				table.insert(components, ("[%s]"):format(diagnostic.code))
			end

			return table.concat(components, " ")
		end,
	},
})

vim.api.nvim_create_user_command("Diagnostics", function()
	local ok, choice = pcall(vim.fn.confirm, "", "&Document\n&workspace")
	if not ok then
		return
	elseif choice == 1 then
		vim.diagnostic.setloclist()
	elseif choice == 2 then
		vim.diagnostic.setqflist()
	end
end, { desc = "add buffer diagonstics to location list" })
