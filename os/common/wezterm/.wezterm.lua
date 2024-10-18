-- Import the WezTerm API
local wezterm = require 'wezterm'

-- Create a function to merge tables
local function merge_tables(original, updates)
  for k, v in pairs(updates) do
    original[k] = v
  end
  return original
end

-- Create the base configuration
local config = wezterm.config_builder()

-- New configurations that will overwrite the base settings
local new_config = {
  -- Color scheme setting
  color_scheme = 'GruvboxDark',

  -- Font configuration
  font = wezterm.font("Delugia"),
  bold_brightens_ansi_colors = true,
  font_size = 18,
  harfbuzz_features = { 'calt=1', 'clig=1', 'liga=1', 'dlig=1', 'hlig=1', 'salt=1', 'rlig=1' },

  -- Tab bar settings
  enable_tab_bar = false,
  show_new_tab_button_in_tab_bar = true,
  show_tab_index_in_tab_bar = false,
  use_fancy_tab_bar = true,

  -- Window decorations and padding
  window_decorations = "RESIZE|MACOS_FORCE_ENABLE_SHADOW",
  window_padding = {
    left = '30pt',
    right = '30pt',
    top = '30pt',
    bottom = '30pt',
  },

  -- Window frame styling
  window_frame = {
    border_left_width = '15px',
    border_right_width = '15px',
    border_bottom_height = '15px',
    border_top_height = '15px',
    border_left_color = '#343434',
    border_right_color = '#343434',
    border_bottom_color = '#343434',
    border_top_color = '#343434',
    inactive_titlebar_bg = '#353535',
    active_titlebar_bg = '#2b2042',
    inactive_titlebar_fg = '#cccccc',
    active_titlebar_fg = '#ffffff',
    inactive_titlebar_border_bottom = '#2b2042',
    active_titlebar_border_bottom = '#2b2042',
    button_fg = '#cccccc',
    button_bg = '#2b2042',
    button_hover_fg = '#ffffff',
    button_hover_bg = '#3b3052',
    font = wezterm.font 'Delugia',
    font_size = 12,
  },

  -- Transparency and visual effects
  window_background_opacity = 0.95,
  macos_window_background_blur = 10,

  -- Window close confirmation settings
  window_close_confirmation = 'NeverPrompt',
  skip_close_confirmation_for_processes_named = {
    'bash', 'sh', 'zsh', 'fish', 'tmux', 'nu', 'cmd.exe', 'pwsh.exe', 'powershell.exe',
  },

  -- Keybinding for closing tabs
  keys = {
    {
      key = 'w',
      mods = 'CMD',
      action = wezterm.action.CloseCurrentTab { confirm = true },
    },
  },

  -- Scrollbar and scrollback settings
  enable_scroll_bar = false,
  scrollback_lines = 3500,

  -- Hyperlink rules
  hyperlink_rules = wezterm.default_hyperlink_rules(),

  -- Cursor configuration
  default_cursor_style = "BlinkingBar",
  cursor_blink_rate = 800,
  cursor_blink_ease_in = 'Linear',
  cursor_blink_ease_out = 'Linear',
  cursor_thickness = 3,
  custom_block_glyphs = true,

  -- Miscellaneous settings
  adjust_window_size_when_changing_font_size = true,
  display_pixel_geometry = "RGB",
  enable_wayland = true,
  exit_behavior_messaging = "Verbose",
  exit_behavior = "CloseOnCleanExit",
  font_shaper = "Harfbuzz",
  hide_mouse_cursor_when_typing = true,
  initial_cols = 80,
  initial_rows = 24,
}

-- Merge the base configuration with the new settings
config = merge_tables(config, new_config)

-- Return the final configuration to WezTerm
return config
