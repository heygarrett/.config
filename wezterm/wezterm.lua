local wezterm = require("wezterm")

return {
	use_fancy_tab_bar = false,
	tab_bar_at_bottom = true,
	font = wezterm.font("Monocraft"),
	font_size = 10.5,
	harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
	color_scheme = "Catppuccin Mocha",
	native_macos_fullscreen_mode = true,
	keys = {
		{
			key = "f",
			mods = "CTRL|CMD",
			action = wezterm.action.ToggleFullScreen,
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
