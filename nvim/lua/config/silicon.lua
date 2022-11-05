return {
	"NarutoXY/silicon.lua",
	config = function()
		local loaded, silicon = pcall(require, "silicon")
		if not loaded then return end

		silicon.setup({
			theme = "Dracula",
			font = "Monocraft",
			padHoriz = "30",
			padVert = "30",
		})

		vim.api.nvim_create_user_command(
			"Silicon",
			function(t) silicon.visualise_api({ to_clip = t.args ~= "save" }) end,
			{ range = true, nargs = "?" }
		)
	end,
}
