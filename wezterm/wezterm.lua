local wezterm = require("wezterm")

return {
	color_scheme = "Catppuccin Mocha",
	font = wezterm.font("Monocraft"),
	font_size = 10.5,
	harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
	native_macos_fullscreen_mode = true,
	tab_bar_at_bottom = true,
	use_fancy_tab_bar = false,

	keys = {
		{
			key = "f",
			mods = "CTRL|CMD",
			action = wezterm.action.ToggleFullScreen,
		},
		{
			key = "t",
			mods = "CMD",
			action = wezterm.action.SpawnCommandInNewTab({ cwd = wezterm.home_dir }),
		},
		{
			key = "Enter",
			mods = "CTRL|SHIFT",
			action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "{",
			mods = "CTRL|SHIFT",
			action = wezterm.action.ActivatePaneDirection("Left"),
		},
		{
			key = "}",
			mods = "CTRL|SHIFT",
			action = wezterm.action.ActivatePaneDirection("Right"),
		},
	},
}
