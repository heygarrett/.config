local wezterm = require("wezterm")

return {
	color_scheme = "Catppuccin Mocha",

	font = wezterm.font_with_fallback({
		{ family = "Miracode" },
		"Symbols Nerd Font",
	}),
	font_size = 10,
	line_height = 1,
	harfbuzz_features = { "calt=0", "clig=0", "liga=0" },

	native_macos_fullscreen_mode = true,
	tab_bar_at_bottom = true,
	tab_max_width = 1000,
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
			action = wezterm.action.SpawnCommandInNewTab({
				cwd = wezterm.home_dir,
			}),
		},
		{
			key = "Enter",
			mods = "CTRL|SHIFT",
			action = wezterm.action.SplitHorizontal({
				domain = "CurrentPaneDomain",
			}),
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
		{
			key = "{",
			mods = "OPT|SHIFT",
			action = wezterm.action.RotatePanes("CounterClockwise"),
		},
		{
			key = "}",
			mods = "OPT|SHIFT",
			action = wezterm.action.RotatePanes("Clockwise"),
		},
		{
			key = "Tab",
			mods = "OPT|SHIFT",
			action = wezterm.action.MoveTabRelative(-1),
		},
		{
			key = "Tab",
			mods = "OPT",
			action = wezterm.action.MoveTabRelative(1),
		},

		-- disable font size adjustments using CTRL
		{
			key = "-",
			mods = "CTRL",
			action = wezterm.action.DisableDefaultAssignment,
		},
		{
			key = "_",
			mods = "CTRL|SHIFT",
			action = wezterm.action.DisableDefaultAssignment,
		},
		{
			key = "=",
			mods = "CTRL",
			action = wezterm.action.DisableDefaultAssignment,
		},
		{
			key = "+",
			mods = "CTRL|SHIFT",
			action = wezterm.action.DisableDefaultAssignment,
		},
		{
			key = "0",
			mods = "CTRL",
			action = wezterm.action.DisableDefaultAssignment,
		},
		{
			key = ")",
			mods = "CTRL|SHIFT",
			action = wezterm.action.DisableDefaultAssignment,
		},
	},
}
