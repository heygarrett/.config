return {
	"NarutoXY/silicon.lua",
	config = function()
		local loaded, silicon = pcall(require, "silicon")
		if not loaded then return end

		silicon.setup({
			font = "Monocraft",
			padHoriz = "20",
			padVert = "20",
			gobble = true,
		})

		vim.api.nvim_create_user_command(
			"Silicon",
			function(t) silicon.visualise_cmdline({ to_clip = t.args ~= "save" }) end,
			{ range = true, nargs = "?" }
		)
	end,
}
