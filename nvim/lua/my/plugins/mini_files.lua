return {
	"https://github.com/echasnovski/mini.files",
	config = function()
		local mini_files = require("mini.files")
		mini_files.setup()

		vim.api.nvim_create_user_command(
			"Ex",
			function() mini_files.open(vim.api.nvim_buf_get_name(0)) end,
			{ desc = "open mini.files browser" }
		)

		---@return string | nil
		local function get_entry_path()
			local entry = mini_files.get_fs_entry()
			if not entry then
				vim.notify("Invalid entry", vim.log.levels.WARN, {
					title = "mini.files",
				})
				return
			end
			return entry.path
		end

		---@param direction "vertical" | "horizontal"
		local function open_in_split(direction)
			local target_window = mini_files.get_target_window()
			if not target_window then
				return
			end
			local entry_path = get_entry_path()
			if not entry_path then
				return
			end
			vim.api.nvim_win_call(target_window, function()
				vim.cmd.split({
					mods = { vertical = direction == "vertical" },
					args = { entry_path },
				})
				mini_files.set_target_window(vim.api.nvim_get_current_win())
			end)
		end

		local group = vim.api.nvim_create_augroup("mini.files", { clear = true })
		vim.api.nvim_create_autocmd("User", {
			pattern = "MiniFilesBufferCreate",
			desc = "define commands/keymaps for mini.files",
			group = group,
			callback = function(args)
				local buf_id = args.data.buf_id
				vim.keymap.set("n", "<c-v>", function() open_in_split("vertical") end, {
					buffer = buf_id,
					desc = "open mini.files entry in vertical split",
				})
				vim.keymap.set("n", "<c-x>", function() open_in_split("horizontal") end, {
					buffer = buf_id,
					desc = "open mini.files entry in horizontal split",
				})
				vim.keymap.set("n", "<c-t>", function()
					local entry_path = get_entry_path()
					if not entry_path then
						return
					end
					mini_files.close()
					vim.cmd.tabedit({ args = { entry_path } })
					vim.cmd.Ex()
				end, {
					buffer = buf_id,
					desc = "open mini.files entry in new tab",
				})
				vim.keymap.set(
					"n",
					"_",
					function() mini_files.open(vim.fn.getcwd()) end,
					{ desc = "jump to cwd in mini.files browser" }
				)
			end,
		})
	end,
}
