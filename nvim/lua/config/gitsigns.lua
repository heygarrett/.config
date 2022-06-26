return {
	"lewis6991/gitsigns.nvim",
	config = function()
		vim.opt.signcolumn = "yes:1"
		require("gitsigns").setup {
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end
				map("n", "]h", function()
				if vim.wo.diff then return "]h" end
					vim.schedule(function() gs.next_hunk() end)
					return "<Ignore>"
				end, { expr = true })

				map("n", "[h", function()
					if vim.wo.diff then return "[h" end
					vim.schedule(function() gs.prev_hunk() end)
					return "<Ignore>"
				end, { expr = true })

				vim.api.nvim_create_user_command("Blame", function() gs.blame_line({ full = true }) end, {})
				vim.api.nvim_create_user_command("Diff", gs.preview_hunk, {})
				vim.api.nvim_create_user_command("Stage", "'<,'>Gitsigns stage_hunk", { range = true })
				vim.api.nvim_create_user_command("Unstage", gs.undo_stage_hunk, {})
			end
		}
	end
}
