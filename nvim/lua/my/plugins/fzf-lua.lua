---@param submodule? string
local fzf_lua = function(submodule)
	local module_path = table.concat({ "fzf-lua", submodule }, ".")
	return require(module_path)
end

return {
	"https://codeberg.org/ibhagwan/fzf-lua",
	cmd = "FzfLua",
	keys = {
		{
			"<leader>p",
			function()
				fzf_lua().builtin()
			end,
			mode = { "n" },
		},
		{
			"<leader>r",
			function()
				fzf_lua().resume()
			end,
			mode = { "n" },
		},
	},
	config = function()
		fzf_lua().setup({
			"hide",
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
			defaults = { jump1 = false },
			helptags = {
				actions = { ["enter"] = fzf_lua("actions").help_vert },
			},
			diagnostics = { diag_source = true },
			grep = { hidden = true },
			files = {
				find_opts = [[-type df -not -path '*/\.git/*' -printf '%P\n']],
				fd_opts = [[--color=never --type file --type dir --hidden --follow --exclude .git]],
				actions = {
					["ctrl-g"] = false,
					["ctrl-l"] = {
						-- filter by selected subdirectory
						function(selected, opts)
							local cwd = opts.cwd or vim.uv.cwd()
							if not cwd then
								return
							end
							local entry = fzf_lua().path.entry_to_file(selected[1])
							if not fzf_lua().path.is_absolute(entry.path) then
								entry.path = vim.fs.joinpath(cwd, entry.path)
							end
							fzf_lua().files({ cwd = entry.path })
						end,
					},
					["ctrl-h"] = {
						-- expand filter to parent directory
						function(_, opts)
							local cwd = opts.cwd or vim.uv.cwd()
							if not cwd then
								return
							end
							fzf_lua().files({
								cwd = vim.fn.fnamemodify(vim.fs.normalize(cwd), ":h"),
							})
						end,
					},
				},
			},
		})
	end,
}
