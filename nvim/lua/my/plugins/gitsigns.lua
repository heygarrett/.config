return {
	"https://github.com/lewis6991/gitsigns.nvim",
	config = function()
		local gitsigns = require("gitsigns")

		vim.o.signcolumn = "yes:1"
		gitsigns.setup({
			on_attach = function(bufnr)
				vim.keymap.set("n", "]h", function()
					if vim.wo.diff then
						return "]h"
					end
					vim.schedule(function() gitsigns.next_hunk() end)
					return "<Ignore>"
				end, {
					buffer = bufnr,
					expr = true,
					desc = "gitsigns: go to next hunk",
				})
				vim.keymap.set("n", "[h", function()
					if vim.wo.diff then
						return "[h"
					end
					vim.schedule(function() gitsigns.prev_hunk() end)
					return "<Ignore>"
				end, {
					buffer = bufnr,
					expr = true,
					desc = "gitsigns: go to previous hunk",
				})

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

				vim.api.nvim_create_user_command(
					"Diff",
					gitsigns.preview_hunk_inline,
					{ desc = "gitsigns: preview hunk diff" }
				)
				vim.api.nvim_create_user_command("Patch", function(t)
					local base = t.args ~= "" and t.args or nil
					gitsigns.diffthis(base)
				end, {
					nargs = "?",
					complete = function(ArgLead)
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
					end,
					desc = "gitsigns: diff whole buffer",
				})
				vim.api.nvim_create_user_command(
					"Blame",
					function() gitsigns.blame_line({ full = true }) end,
					{ desc = "gitsigns: blame current line" }
				)
				vim.api.nvim_create_user_command(
					"Reset",
					function(selection)
						hunk_range(
							{ hunk = gitsigns.reset_hunk, buffer = gitsigns.reset_buffer },
							selection
						)
					end,
					{
						range = true,
						desc = "gitsigns: reset",
					}
				)
				vim.api.nvim_create_user_command(
					"Stage",
					function(selection)
						hunk_range(
							{ hunk = gitsigns.stage_hunk, buffer = gitsigns.stage_buffer },
							selection
						)
					end,
					{
						range = true,
						desc = "gitsigns: stage hunk",
					}
				)
				vim.api.nvim_create_user_command("Unstage", function(selection)
					if selection.range == 0 then
						gitsigns.undo_stage_hunk()
					else
						gitsigns.reset_buffer_index()
					end
				end, {
					range = true,
					desc = "gitsigns: unstage hunk",
				})
			end,
		})
	end,
}
