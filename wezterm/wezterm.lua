local wezterm = require 'wezterm'
local mux = wezterm.mux
local act = wezterm.action

local config = {}
local keys = {}
local mouse_bindings = {}
local launch_menu = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

--- Default config settings
config.color_scheme = 'Oceanic Next (Gogh)'
config.font = wezterm.font('Hack Nerd Font')
config.font_size = 11
config.launch_menu = launch_menu
config.default_cursor_style = 'BlinkingBar'
config.disable_default_key_bindings = true
config.keys = {{ key = 'V', mods = 'CTRL', action = act.PasteFrom 'Clipboard' },}
config.mouse_bindings = mouse_bindings

mouse_bindings = {
  {
    event = { Down = { streak = 3, button = 'Left' } },
    action = wezterm.action.SelectTextAtMouseCursor 'SemanticZone',
    mods = 'NONE',
  },
	{
		event = { Down = { streak = 1, button = "Right" } },
		mods = "NONE",
		action = wezterm.action_callback(function(window, pane)
			local has_selection = window:get_selection_text_for_pane(pane) ~= ""
			if has_selection then
				window:perform_action(act.CopyTo("ClipboardAndPrimarySelection"), pane)
				window:perform_action(act.ClearSelection, pane)
			else
				window:perform_action(act({ PasteFrom = "Clipboard" }), pane)
			end
		end),
	},
}

config.foreground_text_hsb = {
  hue = 1.0,
  saturation = 1.2,
  brightness = 1.5,
}

config.background = {
    {
        source = { File = {path = 'C:/Users/someuserboi/Pictures/Backgrounds/theone.gif', speed = 0.2}},
	opacity = 1,
	width = "100%",
	hsb = {brightness = 0.5},
    }
}

config.default_domain = 'WSL:Ubuntu-22.04'

return config