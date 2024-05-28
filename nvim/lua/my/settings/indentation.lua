-- Default to tabs
vim.o.expandtab = false
vim.o.shiftwidth = 0
vim.o.softtabstop = -1
vim.o.tabstop = 4
vim.opt.listchars = { space = "·", tab = "| " }

-- Don't run editorconfig automatically
vim.g.editorconfig = false

local group = vim.api.nvim_create_augroup("indentation", { clear = true })
vim.api.nvim_create_autocmd("BufWinEnter", {
	desc = "indentation settings",
	group = group,
	callback = function(args)
		-- Override expandtab set by ftplugins
		vim.bo.expandtab = vim.go.expandtab

		-- Load editorconfig
		require("editorconfig").config(args.buf)

		-- Run guess-indent
		local guess_indent_loaded, guess_indent = pcall(require, "guess-indent")
		if guess_indent_loaded then
			-- defers to editorconfig
			vim.cmd.GuessIndent({
				args = { "auto_cmd" },
				mods = { silent = true },
			})
			-- get indent size from buffer if editorconfig specifies spaces for
			-- indentation but not the size of the indent
			if
				vim.b.editorconfig
				and vim.b.editorconfig.indent_style == "space"
				and not vim.b.editorconfig.indent_size
			then
				local indent = guess_indent.guess_from_buffer()
				if indent ~= "tabs" then
					vim.bo.tabstop = tonumber(indent)
				end
			end
		end

		-- Finalize listchars and reset softtabstop
		vim.cmd.Relist()
	end,
})

vim.api.nvim_create_user_command("Relist", function()
	if vim.bo.expandtab then
		-- Set whitespace characters for indentation with spaces
		vim.opt_local.listchars = vim.tbl_extend(
			"force",
			vim.opt_global.listchars:get(),
			{ leadmultispace = ":" .. (" "):rep(vim.bo.tabstop - 1) }
		)
	else
		-- Remove leadmultispace from listchars
		vim.wo.listchars = vim.go.listchars
		-- Override tabstop if we're using tabs
		vim.bo.tabstop = vim.go.tabstop
	end

	-- Reset shiftwidth and softtabstop
	vim.bo.shiftwidth = vim.go.shiftwidth
	vim.bo.softtabstop = vim.go.softtabstop
end, { desc = "re-set listchars" })
