vim.pack.add({
	{
		src = "https://codeberg.org/ibhagwan/fzf-lua",
		version = "main",
	},
})

---@param submodule? string
local fzf_lua = function(submodule)
	local module_path = table.concat({ "fzf-lua", submodule }, ".")
	return require(module_path)
end

---@param file_name string
---@param cwd string
---@return string
local get_corrected_path = function(file_name, cwd)
	local entry = fzf_lua().path.entry_to_file(file_name)
	if not fzf_lua().path.is_absolute(entry.path) then
		entry.path = vim.fs.joinpath(cwd, entry.path)
	end

	return entry.path
end

fzf_lua().setup({
	"hide",
	ui_select = true,
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
			-- HACK: https://github.com/ibhagwan/fzf-lua/discussions/2608
			["enter"] = function(selected, opts)
				local entry_path = get_corrected_path(selected[1], opts.cwd)
				vim.cmd.edit({
					args = { entry_path },
				})
			end,
			["ctrl-s"] = function(selected, opts)
				vim.cmd.split({
					args = { get_corrected_path(selected[1], opts.cwd) },
				})
			end,
			["ctrl-v"] = function(selected, opts)
				vim.cmd.vsplit({
					args = { get_corrected_path(selected[1], opts.cwd) },
				})
			end,
			["ctrl-t"] = function(selected, opts)
				vim.cmd.tabedit({
					args = { get_corrected_path(selected[1], opts.cwd) },
				})
			end,
			-- filter by selected subdirectory
			["ctrl-l"] = function(selected, opts)
				fzf_lua().files({ cwd = get_corrected_path(selected[1], opts.cwd) })
			end,
			-- expand filter to parent directory
			["ctrl-h"] = function(_, opts)
				fzf_lua().files({
					cwd = vim.fn.fnamemodify(vim.fs.normalize(opts.cwd), ":h"),
				})
			end,
		},
	},
})

vim.keymap.set({ "n" }, "<leader>p", function()
	fzf_lua().builtin()
end)
vim.keymap.set({ "n" }, "<leader>r", function()
	fzf_lua().resume()
end)
