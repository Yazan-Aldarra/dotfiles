-- Pull in the wezterm API
local wezterm = require("wezterm")
-- This will hold the configuration.
local config = wezterm.config_builder()

config.automatically_reload_config = true
config.adjust_window_size_when_changing_font_size = false

config.front_end = "OpenGL"
config.max_fps = 144
config.default_cursor_style = "BlinkingBlock"
config.animation_fps = 1
config.cursor_blink_rate = 500
config.term = "xterm-256color" -- Set the terminal type

config.font = wezterm.font("Consolas")

config.cell_width = 1

local transparent_opacity = 1
config.window_background_opacity = transparent_opacity
config.prefer_egl = true
config.font_size = 18

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

-- tabs
config.hide_tab_bar_if_only_one_tab = false
config.hide_mouse_cursor_when_typing = true
config.use_fancy_tab_bar = false

-- Initialize the toggle variable if it doesn't exist
config.enable_tab_bar = config.enable_tab_bar or true

-- keymaps
config.disable_default_key_bindings = true

local function toggle_tab_bar(window, pane)
	local overrides = window:get_config_overrides() or {}
	if overrides.enable_tab_bar == false then
		wezterm.log_info("Tab bar shown")
		overrides.enable_tab_bar = true
	else
		wezterm.log_info("Tab bar hidden")
		overrides.enable_tab_bar = false
	end
	window:set_config_overrides(overrides)
end

local act = wezterm.action

config.keys = {
	{ key = "1", mods = "ALT", action = act.ActivateTab(0) },
	{ key = "2", mods = "ALT", action = act.ActivateTab(1) },
	{ key = "3", mods = "ALT", action = act.ActivateTab(2) },
	{ key = "4", mods = "ALT", action = act.ActivateTab(3) },
	{ key = "5", mods = "ALT", action = act.ActivateTab(4) },
	{ key = "6", mods = "ALT", action = act.ActivateTab(5) },
	{ key = "7", mods = "ALT", action = act.ActivateTab(6) },
	{ key = "8", mods = "ALT", action = act.ActivateTab(7) },
	{ key = "9", mods = "ALT", action = act.ActivateTab(-1) },
	{ key = "p", mods = "ALT", action = act.ActivateCommandPalette },

	-- essential terminal keympas
	{ key = "Enter", mods = "ALT", action = act.ToggleFullScreen },
	{ key = "=", mods = "ALT", action = act.IncreaseFontSize },
	{ key = "-", mods = "ALT", action = act.DecreaseFontSize },
	{ key = "=", mods = "CTRL", action = act.IncreaseFontSize },
	{ key = "-", mods = "CTRL", action = act.DecreaseFontSize },
	{ key = "s", mods = "ALT", action = act.ShowTabNavigator },
	{ key = "d", mods = "CTRL|ALT", action = act.ShowDebugOverlay },
	{
		key = "o",
		mods = "CTRL|ALT",
		-- toggling opacity
		action = wezterm.action_callback(function(window, _)
			local overrides = window:get_config_overrides() or {}
			if overrides.window_background_opacity == 1.0 then
				overrides.window_background_opacity = transparent_opacity
			else
				overrides.window_background_opacity = 1.0
			end
			window:set_config_overrides(overrides)
		end),
	},

	{ key = "Insert", mods = "SHIFT", action = act.PasteFrom("PrimarySelection") },
	{ key = "Insert", mods = "CTRL", action = act.CopyTo("PrimarySelection") },
	{
		key = "i",
		mods = "ALT",
		action = wezterm.action_callback(toggle_tab_bar),
	},

	-- keymaps by yazan
	{
		key = "t",
		mods = "ALT",
		action = wezterm.action.SpawnTab("CurrentPaneDomain"),
	},
	{
		key = "w",
		mods = "ALT",
		action = wezterm.action.CloseCurrentTab({ confirm = true }),
	},
	{
		key = " ",
		mods = "CTRL",
		action = wezterm.action.SendKey({ mods = "CTRL", key = " " }),
	},
	-- / keympas by yazan
}

config.window_frame = {
	font = wezterm.font({ family = "Iosevka Custom", weight = "Regular" }),
	active_titlebar_bg = "#0c0b0f",
}

config.window_decorations = "NONE | RESIZE"
config.default_prog = { "C:\\Program Files\\Git\\bin\\bash.exe", "-c", "zsh" }
-- config.default_prog = { "C:\\Program Files\\Git\\usr\\bin\\zsh.exe" }
config.initial_cols = 80

-- One Dark theme with pure black background
local onedark_theme = {
	-- WezTerm Palette fields
	foreground = "#abb2bf",
	background = "#000000", -- Pure black background
	cursor_bg = "#e767f1",
	cursor_border = "#ed586e",
	cursor_fg = "#000000",
	selection_bg = "#3e4451",
	selection_fg = "#abb2bf",

	-- Tab bar and UI elements
	tab_bar = {
		background = "#0a0a0a", -- Slightly lighter than pure black for UI separation
		active_tab = {
			bg_color = "#000000",
			fg_color = "#abb2bf",
			intensity = "Normal",
		},
		inactive_tab = {
			bg_color = "#0a0a0a",
			fg_color = "#5c6370",
		},
		inactive_tab_hover = {
			bg_color = "#1a1a1a",
			fg_color = "#abb2bf",
		},
		new_tab = {
			bg_color = "#0a0a0a",
			fg_color = "#abb2bf",
		},
		new_tab_hover = {
			bg_color = "#1a1a1a",
			fg_color = "#abb2bf",
		},
	},

	ansi = {
		"#000000", -- Black (pure black)
		"#e06c75", -- Red
		"#98c379", -- Green
		"#e5c07b", -- Yellow
		"#61afef", -- Blue
		"#c678dd", -- Magenta
		"#56b6c2", -- Cyan
		"#abb2bf", -- White
	},
	brights = {
		"#4a4a4a", -- Bright Black (visible dark gray)
		"#ff7b85", -- Bright Red (brighter for visibility)
		"#a8e38b", -- Bright Green (brighter)
		"#ffd37b", -- Bright Yellow (brighter)
		"#7bbfff", -- Bright Blue (brighter)
		"#da8aee", -- Bright Magenta (brighter)
		"#6cc6d2", -- Bright Cyan (brighter)
		"#ffffff", -- Bright White (pure white)
	},
}

-- config.color_schemes = {
-- 	["One Dark (Black)"] = onedark_theme,
-- }
-- config.color_scheme = "One Dark (Black)"

config.color_scheme = "Catppuccin Mocha"

-- Update window frame to match
config.window_frame = {
	font = wezterm.font({ family = "Iosevka Custom", weight = "Regular" }),
	active_titlebar_bg = "#0a0a0a",
}

-- Full colors table for modal.wezterm plugin
-- config.colors = {
-- 	-- ANSI colors
-- 	ansi = {
-- 		"#000000",
-- 		"#e06c75",
-- 		"#98c379",
-- 		"#e5c07b",
-- 		"#61afef",
-- 		"#c678dd",
-- 		"#56b6c2",
-- 		"#abb2bf",
-- 	},
-- 	brights = {
-- 		"#4a4a4a",
-- 		"#ff7b85",
-- 		"#a8e38b",
-- 		"#ffd37b",
-- 		"#7bbfff",
-- 		"#da8aee",
-- 		"#6cc6d2",
-- 		"#ffffff",
-- 	},
-- 	-- Named UI colors (required by plugin)
-- 	foreground = "#abb2bf",
-- 	background = "#000000",
-- 	cursor_bg = "#e767f1",
-- 	cursor_border = "#ed586e",
-- 	cursor_fg = "#000000",
-- 	selection_bg = "#3e4451",
-- 	selection_fg = "#abb2bf",
-- 	-- Tab bar colors
-- 	tab_bar = {
-- 		background = "#0a0a0a",
-- 		active_tab = {
-- 			bg_color = "#000000",
-- 			fg_color = "#abb2bf",
-- 		},
-- 		inactive_tab = {
-- 			bg_color = "#0a0a0a",
-- 			fg_color = "#5c6370",
-- 		},
-- 		inactive_tab_hover = {
-- 			bg_color = "#1a1a1a",
-- 			fg_color = "#abb2bf",
-- 		},
-- 	},
-- }

-- Plugins
local modal = wezterm.plugin.require("https://github.com/MLFlexer/modal.wezterm")
modal.apply_to_config(config)
modal.set_default_keys(config)

local key_table = require("ui_mode").key_table

local icons = {
	left_seperator = wezterm.nerdfonts.ple_left_half_circle_thick,
	key_hint_seperator = " | ",
	mod_seperator = "-",
}
local hint_colors = {
	key_hint_seperator = "Yellow",
	key = "Green",
	hint = "Red",
	bg = "Black",
	left_bg = "Gray",
}
local mode_colors = { bg = "Red", fg = "Black" }
local status_text = require("ui_mode").get_hint_status_text(icons, hint_colors, mode_colors)

modal.add_mode("visual_mode", key_table, status_text)

table.insert(config.keys, {
	key = "u",
	mods = "ALT",
	action = modal.activate_mode("visual_mode"),
})

config.key_tables = modal.key_tables

local agent_deck = wezterm.plugin.require("https://github.com/Eric162/wezterm-agent-deck")
agent_deck.apply_to_config(config)

config.window_frame = {
	active_titlebar_bg = "none",
	inactive_titlebar_bg = "none",
}
-- config.colors.tab_bar.background = "rgba(0,0,0,0)"
-- config.colors.tab_bar.active_tab.bg_color = "rgba(0,0,0,0)"
-- config.colors.tab_bar.active_tab.fg_color = "#c678dd"
-- config.colors.tab_bar.inactive_tab.bg_color = "rgba(0,0,0,0)"
--
-- config.colors.tab_bar.new_tab = {
-- 	bg_color = "rgba(0,0,0,0)",
-- 	fg_color = "rgba(0,0,0,0)",
-- }

local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
tabline.setup({
	options = {
		icons_enabled = true,
		-- theme = config.color_schemes["One Dark (Black)"],
		tabs_enabled = true,
		section_separators = {
			left = wezterm.nerdfonts.pl_left_hard_divider,
			right = wezterm.nerdfonts.pl_right_hard_divider,
		},
		component_separators = {
			left = wezterm.nerdfonts.pl_left_soft_divider,
			right = wezterm.nerdfonts.pl_right_soft_divider,
		},
		tab_separators = {
			left = wezterm.nerdfonts.pl_left_hard_divider,
			right = wezterm.nerdfonts.pl_right_hard_divider,
		},
		theme_overrides = {
			visual_mode = {
				a = { fg = "#000000", bg = "#e06c75" },
				b = { fg = "#213123", bg = "#313244" },
				c = { fg = "#abb2bf", bg = "rgba(0,0,0,0)" },
			},
			normal_mode = {
				a = { fg = "#000000", bg = "#d35edc" },
				c = { fg = "#abb2bf", bg = "rgba(0,0,0,0)" },
			},
		},
	},
	sections = {
		tabline_a = { { "mode" } },
		tabline_b = {},
		-- tabline_b = { "workspace" },
		tabline_c = { "" },
		tab_active = {
			"index",
			{ "parent", padding = 1 },
			"/",
			{ "cwd", padding = { left = 0, right = 1 } },
			{ "zoomed", padding = 0 },
		},
		tab_inactive = { "index", { "process", padding = { left = 0, right = 1 } } },
		tabline_x = { "ram", "cpu" },
		-- tabline_y = { "datetime", "battery" },
		tabline_y = {},
		tabline_z = {},
		-- tabline_z = { "domain" },
	},
	extensions = {},
})

config.tab_bar_at_bottom = true
-- This refreshes ONLY the tabline when modes change
wezterm.on("modal.enter", function(name, window, pane)
	-- Refresh just the tabline components (not tabs)
	tabline.refresh(window, nil)
end)

wezterm.on("modal.exit", function(name, window, pane)
	-- Refresh just the tabline components when exiting
	tabline.refresh(window, nil)
end)

return config
