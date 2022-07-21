return {
	"lewis6991/gitsigns.nvim",
	config = function()
		vim.opt.signcolumn = "yes:1"
		require("gitsigns").setup({
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				map("n", "]h", function()
					if vim.wo.diff then
						return "]h"
					end
					vim.schedule(function()
						gs.next_hunk()
					end)
					return "<Ignore>"
				end, { expr = true })

				map("n", "[h", function()
					if vim.wo.diff then
						return "[h"
					end
					vim.schedule(function()
						gs.prev_hunk()
					end)
					return "<Ignore>"
				end, { expr = true })

				local function hunk_range(stage, selection)
					if selection.range ~= 0 then
						if selection.line1 == 1 and selection.line2 == vim.fn.line("$") then
							stage["buffer"]()
						else
							stage["hunk"]({ selection.line1, selection.line2 })
						end
					else
						stage["hunk"]()
					end
				end

				vim.api.nvim_create_user_command("Diff", gs.preview_hunk, {})
				vim.api.nvim_create_user_command("Unstage", gs.undo_stage_hunk, {})
				vim.api.nvim_create_user_command("Blame", function()
					gs.blame_line({ full = true })
				end, {})
				vim.api.nvim_create_user_command("Reset", function(selection)
					hunk_range({ hunk = gs.reset_hunk, buffer = gs.reset_buffer }, selection)
				end, { range = true })
				vim.api.nvim_create_user_command("Stage", function(selection)
					hunk_range({ hunk = gs.stage_hunk, buffer = gs.stage_buffer }, selection)
				end, { range = true })
			end,
		})
	end,
}
