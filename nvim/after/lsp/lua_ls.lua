---@type vim.lsp.Config
return {
	settings = {
		Lua = {
			hint = {
				enable = true,
				---@type "Auto" | "Enable" | "Disable"
				arrayIndex = "Disable",
				-- await = true,
				-- awaitPropagate = false,
				---@type "All" | "Literal" | "Disable"
				paramName = "Literal",
				-- paramType = true,
				-- ---@type "All" | "SameLine" | "Disable"
				-- semicolon = "SameLine",
				setType = true,
			},
		},
	},
	on_init = function(client)
		local ok, workspace_folder = pcall(unpack, client.workspace_folders)
		if not ok then
			return
		end
		local path = workspace_folder.name
		if
			vim.uv.fs_stat(vim.fs.joinpath(path, ".luarc.json"))
			or vim.uv.fs_stat(vim.fs.joinpath(path, ".luarc.jsonc"))
		then
			return
		end

		client.config.settings.Lua =
			---@diagnostic disable-next-line: param-type-mismatch
			vim.tbl_deep_extend("force", client.config.settings.Lua, {
				runtime = { version = "LuaJIT" },
				workspace = {
					checkThirdParty = "Disable",
					library = {
						"${3rd}/luv/library",
						unpack(vim.api.nvim_get_runtime_file("", true)),
					},
				},
			})
	end,
	on_attach = function()
		-- HACK: https://github.com/LuaLS/lua-language-server/issues/1809
		vim.api.nvim_set_hl(0, "@lsp.type.comment", {})
	end,
}
