local wezterm = require 'wezterm'
local act = wezterm.action

local config = wezterm.config_builder()

-- Fonts
config.font = wezterm.font('FiraCode Nerd Font')
config.font_size = 14

-- Colors
local scheme = wezterm.color.get_builtin_schemes()['flexoki-dark']
scheme.background = '#0C0C0C'                        -- override background color
config.color_schemes = { ['flexoki-dark'] = scheme } -- override built-in scheme
config.color_scheme = 'flexoki-dark'
-- config.bold_brightens_ansi_colors = false

-- Key bindings
config.leader = { mods = 'SHIFT', key = 'Space', timeout_milliseconds = 1500 }
config.keys = {
  -- Move the cursor using MacOS standard keyboard shortcuts
  { mods = 'OPT',    key = 'LeftArrow',  action = act.SendString '\x1BB' },
  { mods = 'OPT',    key = 'RightArrow', action = act.SendString '\x1BF' },
  { mods = 'CMD',    key = 'LeftArrow',  action = act.SendString '\x1BOH' },
  { mods = 'CMD',    key = 'RightArrow', action = act.SendString '\x1BOF' },

  -- tmux-like actions
  { mods = 'LEADER', key = 'c',          action = wezterm.action.SpawnTab 'CurrentPaneDomain', },
  { mods = 'LEADER', key = 'C',          action = wezterm.action.SpawnTab 'CurrentPaneDomain', },
  { mods = 'LEADER', key = 'x',          action = wezterm.action.CloseCurrentPane { confirm = true } },
  { mods = 'LEADER', key = 'X',          action = wezterm.action.CloseCurrentPane { confirm = true } },
  { mods = 'LEADER', key = 'b',          action = wezterm.action.ActivateTabRelative(-1) },
  { mods = 'LEADER', key = 'B',          action = wezterm.action.ActivateTabRelative(-1) },
  { mods = 'LEADER', key = 'n',          action = wezterm.action.ActivateTabRelative(1) },
  { mods = 'LEADER', key = 'N',          action = wezterm.action.ActivateTabRelative(1) },
  { mods = 'LEADER', key = '\\',          action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { mods = 'LEADER', key = '|',          action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { mods = 'LEADER', key = '-',          action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },
  { mods = 'LEADER', key = '_',          action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },
  { mods = 'SHIFT', key = 'LeftArrow',          action = wezterm.action.ActivatePaneDirection 'Left' },
  { mods = 'SHIFT', key = 'DownArrow',          action = wezterm.action.ActivatePaneDirection 'Down' },
  { mods = 'SHIFT', key = 'UpArrow',          action = wezterm.action.ActivatePaneDirection 'Up' },
  { mods = 'SHIFT', key = 'RightArrow',          action = wezterm.action.ActivatePaneDirection 'Right' },
  { mods = 'SHIFT|CTRL', key = 'LeftArrow',  action = wezterm.action.AdjustPaneSize { 'Left', 5 } },
  { mods = 'SHIFT|CTRL', key = 'RightArrow', action = wezterm.action.AdjustPaneSize { 'Right', 5 } },
  { mods = 'SHIFT|CTRL', key = 'DownArrow',  action = wezterm.action.AdjustPaneSize { 'Down', 5 } },
  { mods = 'SHIFT|CTRL', key = 'UpArrow',    action = wezterm.action.AdjustPaneSize { 'Up', 5 } },
}
for i = 0, 9 do
    -- leader + number to activate that tab
    table.insert(config.keys, {
        key = tostring(i),
        mods = 'LEADER',
        action = wezterm.action.ActivateTab(i),
    })
end

-- Tabs
config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.tab_and_split_indices_are_zero_based = true

-- Window
config.initial_cols = 120
config.initial_rows = 40
config.window_decorations = "RESIZE"
config.window_padding = { left = 35, right = 35, top = 35, bottom = 35 }
config.window_background_opacity = 0.98

-- Center the window
local function center_window()
  wezterm.on("gui-startup", function(cmd)
    local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
    local screen = wezterm.gui.screens().active

    local gui_window = window:gui_window()

    -- Uncomment if you want to change the window dimensions to a specific screen size factor, such as 0.75
    local width = screen.width * 0.75
    local height = screen.height * 0.75
    gui_window:set_inner_size(width, height)

    local dimensions = gui_window:get_dimensions()
    local x = (screen.width - dimensions.pixel_width) * 0.5
    local y = (screen.height - dimensions.pixel_height) * 0.5

    gui_window:set_position(x, y)
  end)
end
center_window()

-- Rendering
config.front_end = 'WebGpu'
config.animation_fps = 1
config.cursor_blink_ease_in = 'Constant'
config.cursor_blink_ease_out = 'Constant'
config.freetype_load_target = 'Light'
config.freetype_load_flags = 'DEFAULT'

-- Increase cache sizes. Check default values here: https://github.com/wezterm/wezterm/blob/main/config/src/config.rs
config.glyph_cache_image_cache_size = 1024 * 8
config.line_quad_cache_size = 1024 * 8
config.line_state_cache_size = 1024 * 8
config.line_to_ele_shape_cache_size = 1024 * 8
config.shape_cache_size = 1024 * 8

-- FPS
max_fps = 120

return config
