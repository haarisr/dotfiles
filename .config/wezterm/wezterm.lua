local wezterm = require("wezterm")
local config = {}

-- config.color_scheme = "tokyonight_night"
config.color_scheme = "Catppuccin Mocha"
config.cursor_blink_rate = 500
config.enable_scroll_bar = true
config.font_size = 14.0
config.alternate_buffer_wheel_scroll_speed = 10
config.window_background_opacity = 1.0
config.term = "xterm-256color"


config.leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 2000 }
config.keys = {
	{
		key = "h",
		mods = "LEADER",
		action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }),
	},
	{
		key = "v",
		mods = "LEADER",
		action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }),
	},
	{ key = "t", mods = "LEADER", action = wezterm.action({ SpawnTab = "CurrentPaneDomain" }) },
	{ key = "X", mods = "LEADER", action = wezterm.action({ CloseCurrentTab = { confirm = true } }) },
	{ key = "x", mods = "LEADER", action = wezterm.action({ CloseCurrentPane = { confirm = true } }) },
	{ key = "s", mods = "LEADER", action = wezterm.action({ Search = { CaseInSensitiveString = "" } }) },
	{ key = "PageUp", mods = "NONE", action = wezterm.action({ ScrollByPage = -1 }) },
	{ key = "PageDown", mods = "NONE", action = wezterm.action({ ScrollByPage = 1 }) },

	-- { key = "h", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Left") },
	-- { key = "l", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Right") },
	-- { key = "k", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Up") },
	-- { key = "j", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Down") },

	{ key = "LeftArrow", mods = "CTRL|SHIFT", action = wezterm.action.AdjustPaneSize({ "Left", 1 }) },
	{ key = "RightArrow", mods = "CTRL|SHIFT", action = wezterm.action.AdjustPaneSize({ "Right", 1 }) },
	{ key = "UpArrow", mods = "CTRL|SHIFT", action = wezterm.action.AdjustPaneSize({ "Up", 1 }) },
	{ key = "DownArrow", mods = "CTRL|SHIFT", action = wezterm.action.AdjustPaneSize({ "Down", 1 }) },
}

config.colors = {
	compose_cursor = "orange",
}
-- config.font = wezterm.font('JetBrainsMono Nerd Font Mono', {weight= 'DemiBold'})
-- config.font = wezterm.font("Liga SFMono Nerd Font", { weight = "DemiBold" })
-- config.font = wezterm.font("Fira Code", { weight = "DemiBold" })
config.font = wezterm.font("Fira Code")
config.unix_domains = {
	{
		name = "unix",
	},
}

-- The filled in variant of the < symbol
local SOLID_LEFT_ARROW = "|"

-- The filled in variant of the > symbol
local SOLID_RIGHT_ARROW = "|"
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false
config.show_new_tab_button_in_tab_bar = true
config.show_tab_index_in_tab_bar = true
config.show_tabs_in_tab_bar = true
config.tab_bar_at_bottom = true
config.tab_max_width = 25
config.use_fancy_tab_bar = false
config.window_decorations = "RESIZE|TITLE"
-- config.tab_bar_style = {
--     active_tab_left = wezterm.format {
--         { Background = { Color = '#0b0022' } },
--         { Foreground = { Color = '#2b2042' } },
--         { Text = SOLID_LEFT_ARROW },
--     },
--     active_tab_right = wezterm.format {
--         { Background = { Color = '#0b0022' } },
--         { Foreground = { Color = '#2b2042' } },
--         { Text = SOLID_RIGHT_ARROW },
--     },
--     inactive_tab_left = wezterm.format {
--         { Background = { Color = '#0b0022' } },
--         { Foreground = { Color = '#1b1032' } },
--         { Text = SOLID_LEFT_ARROW },
--     },
--     inactive_tab_right = wezterm.format {
--         { Background = { Color = '#0b0022' } },
--         { Foreground = { Color = '#1b1032' } },
--         { Text = SOLID_RIGHT_ARROW },
--     },
-- }

-- local gpus = wezterm.gui.enumerate_gpus()
-- config.webgpu_preferred_adapter = gpus[0]
-- config.front_end = 'WebGpu'
return config
