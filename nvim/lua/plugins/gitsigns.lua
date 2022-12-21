return {
	"lewis6991/gitsigns.nvim",
	config = function()
		local loaded, gitsigns = pcall(require, "gitsigns")
		if not loaded then return end

		vim.o.signcolumn = "yes:1"
		gitsigns.setup({
			on_attach = function(bufnr)
				local opts = { buffer = bufnr, expr = true }
				vim.keymap.set("n", "]h", function()
					if vim.wo.diff then return "]h" end
					vim.schedule(function() gitsigns.next_hunk() end)
					return "<Ignore>"
				end, opts)
				vim.keymap.set("n", "[h", function()
					if vim.wo.diff then return "[h" end
					vim.schedule(function() gitsigns.prev_hunk() end)
					return "<Ignore>"
				end, opts)

				local function hunk_range(stage, selection)
					if selection.range ~= 0 then
						if
							selection.line1 == 1
							and selection.line2 == vim.fn.line("$")
						then
							stage.buffer()
						else
							stage.hunk({ selection.line1, selection.line2 })
						end
					else
						stage.hunk()
					end
				end

				vim.api.nvim_create_user_command("Diff", gitsigns.preview_hunk_inline, {})
				vim.api.nvim_create_user_command(
					"Blame",
					function() gitsigns.blame_line({ full = true }) end,
					{}
				)
				vim.api.nvim_create_user_command(
					"Reset",
					function(selection)
						hunk_range(
							{ hunk = gitsigns.reset_hunk, buffer = gitsigns.reset_buffer },
							selection
						)
					end,
					{ range = true }
				)
				vim.api.nvim_create_user_command(
					"Stage",
					function(selection)
						hunk_range(
							{ hunk = gitsigns.stage_hunk, buffer = gitsigns.stage_buffer },
							selection
						)
					end,
					{ range = true }
				)
				vim.api.nvim_create_user_command("Unstage", function(selection)
					if selection.range == 0 then
						gitsigns.undo_stage_hunk()
					else
						gitsigns.reset_buffer_index()
					end
				end, { range = true })
			end,
		})
	end,
}
