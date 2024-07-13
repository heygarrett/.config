local fzf_lua = function()
	return require("fzf-lua")
end
local helpers = require("my.helpers")

---@param opts { ref: string, file: boolean | nil }
---@return string
local function generate_git_command(opts)
	local command = {
		"git",
		"log",
		"--color",
		"--pretty=format:" .. ([['%s']]):format(table.concat({
			"%C(yellow)%h%Creset",
			"%Cgreen(%><(12)%cr%><|(12))%Creset",
			"%s",
			"%C(blue)<%ae>%Creset",
		}, " ")),
	}
	if opts.ref ~= "" then
		table.insert(command, opts.ref .. "..HEAD")
	end
	if opts.file then
		table.insert(command, "<file>")
	end

	return table.concat(command, " ")
end

---@param selected string[]
local function copy_hash(selected)
	local commit = selected[1]:match("[^ ]+")
	vim.fn.setreg("+", commit)
	---@diagnostic disable: param-type-mismatch
	vim.defer_fn(function()
		vim.notify(commit .. " copied to clipboard!")
	end, 500)
end

return {
	"https://codeberg.org/ibhagwan/fzf-lua",
	lazy = true,
	init = function()
		vim.api.nvim_create_user_command("Autocommands", function()
			fzf_lua().autocmds()
		end, { desc = "fzf-lua picker: autocommands" })
		vim.api.nvim_create_user_command("BCommits", function(tbl)
			fzf_lua().git_bcommits({
				cmd = generate_git_command({ ref = tbl.args, file = true }),
			})
		end, {
			nargs = "?",
			complete = helpers.get_branches,
			desc = "fzf-lua picker: buffer commits",
		})
		vim.api.nvim_create_user_command("Buffers", function()
			fzf_lua().buffers()
		end, { desc = "fzf-lua picker: buffers" })
		vim.api.nvim_create_user_command("Commands", function()
			fzf_lua().commands()
		end, { desc = "fzf-lua picker: user commands" })
		vim.api.nvim_create_user_command("Commits", function(tbl)
			fzf_lua().git_commits({
				cmd = generate_git_command({ ref = tbl.args }),
			})
		end, {
			nargs = "?",
			complete = helpers.get_branches,
			desc = "fzf-lua picker: commits",
		})
		vim.api.nvim_create_user_command("Find", function()
			fzf_lua().files()
		end, { desc = "fzf-lua picker: find files" })
		vim.api.nvim_create_user_command("GFind", function()
			fzf_lua().git_files({ cwd = vim.uv.cwd() })
		end, { desc = "fzf-lua picker: find files tracked by git" })
		vim.api.nvim_create_user_command("Grep", function()
			fzf_lua().live_grep_native()
		end, { desc = "fzf-lua picker: grep" })
		vim.api.nvim_create_user_command("Help", function()
			fzf_lua().help_tags()
		end, { desc = "fzf-lua picker: help tags" })
		vim.api.nvim_create_user_command("Keymaps", function()
			fzf_lua().keymaps()
		end, { desc = "fzf-lua picker: keymaps" })
		vim.api.nvim_create_user_command("Picker", function()
			fzf_lua().resume()
		end, { desc = "fzf-lua picker: re-open last picker" })
		vim.api.nvim_create_user_command("Stashes", function()
			fzf_lua().git_stash()
		end, { desc = "fzf-lua picker: git stashes" })
		vim.api.nvim_create_user_command("Status", function()
			fzf_lua().git_status()
		end, { desc = "fzf-lua picker: git status" })

		-- LSP
		vim.api.nvim_create_user_command("Actions", function()
			fzf_lua().lsp_code_actions()
		end, { desc = "fzf-lua picker: code actions" })
		vim.api.nvim_create_user_command("Definitions", function()
			fzf_lua().lsp_definitions()
		end, { desc = "fzf-lua picker: LSP definitions" })
		vim.api.nvim_create_user_command("Implementations", function()
			fzf_lua().lsp_implementations()
		end, { desc = "fzf-lua picker: LSP implementations" })
		vim.api.nvim_create_user_command("References", function()
			fzf_lua().lsp_references()
		end, { desc = "fzf-lua picker: LSP references" })
		vim.api.nvim_create_user_command("Symbols", function()
			local success, choice = pcall(vim.fn.confirm, "", "&Document\n&workspace")
			if not success then
				return
			elseif choice == 2 then
				fzf_lua().lsp_workspace_symbols()
			else
				fzf_lua().lsp_document_symbols()
			end
		end, { desc = "fzf-lua picker: LSP symbols" })
	end,
	config = function()
		local actions = require("fzf-lua.actions")

		fzf_lua().setup({
			fzf_opts = {
				["--cycle"] = "",
			},
			winopts = {
				preview = {
					layout = "vertical",
					vertical = "down:75%",
				},
			},
			keymap = {
				builtin = {
					["<c-d>"] = "preview-page-down",
					["<c-u>"] = "preview-page-up",
				},
				fzf = {
					["ctrl-d"] = "preview-half-page-down",
					["ctrl-u"] = "preview-half-page-up",
				},
			},
			actions = {
				buffers = {
					["default"] = actions.buf_edit_or_qf,
					["ctrl-s"] = actions.buf_split,
					["ctrl-t"] = actions.buf_tabedit,
					["ctrl-v"] = actions.buf_vsplit,
				},
				files = {
					["default"] = actions.file_edit_or_qf,
					["ctrl-s"] = actions.file_split,
					["ctrl-t"] = actions.file_tabedit,
					["ctrl-v"] = actions.file_vsplit,
				},
			},
			helptags = {
				actions = {
					["default"] = actions.help_vert,
				},
			},
			diagnostics = {
				diag_source = true,
			},
			files = {
				find_opts = [[-type df -not -path '*/\.git/*' -printf '%P\n']],
				fd_opts = [[--color=never --type file --type dir --hidden --follow --exclude .git]],
				actions = { ["ctrl-g"] = false },
			},
			git = {
				files = {
					cmd = "git ls-files --cached --others --exclude-standard",
				},
				status = {
					cmd = "git status --short",
					actions = {
						["right"] = false,
						["left"] = false,
						["tab"] = {
							fn = actions.git_stage_unstage,
							reload = true,
						},
					},
				},
				commits = {
					actions = {
						["default"] = copy_hash,
						["ctrl-y"] = false,
					},
				},
				bcommits = {
					actions = {
						["default"] = copy_hash,
						["ctrl-y"] = false,
					},
				},
			},
		})
	end,
}
