-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

local act = wezterm.action

-- config.keys = {
--  { key = 'V', mods = 'CTRL', action = act.PasteFrom 'Clipboard' },
--  { key = 'V', mods = 'CTRL', action = act.PasteFrom 'PrimarySelection' },
-- }




-- This is where you actually apply your config choices

-- For example, changing the color scheme:
--config.color_scheme = "Catpuccin Mocha"
config.enable_wayland = true
--config.front_end = "OpenGL"
config.front_end = "WebGpu"
config.font_size = 14
config.font = wezterm.font("Jetbrains Mono", {weight = 'Light'})

config.window_background_opacity = 0.3
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.window_frame = {
   -- show_tab_index_in_tab_bar = false
    
}




-- and finally, return the configuration to wezterm
return config
