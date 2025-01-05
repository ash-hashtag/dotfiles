local wezterm = require "wezterm"

-- to make it similar tmux bindings
local keys = {
  {
    key = 'j',
    mods = 'LEADER',
    action = wezterm.action.ActivatePaneDirection "Down",
  },
  {
    key = 'k',
    mods = 'LEADER',
    action = wezterm.action.ActivatePaneDirection "Up",
  },
  {
    key = 'h',
    mods = 'LEADER',
    action = wezterm.action.ActivatePaneDirection "Left",
  },
  {
    key = 'l',
    mods = 'LEADER',
    action = wezterm.action.ActivatePaneDirection "Right",
  },
  {
    key = '%',
    mods = 'LEADER|SHIFT',
    action = wezterm.action.SplitHorizontal
  },
  {
    key = '"',
    mods = 'LEADER|SHIFT',
    action = wezterm.action.SplitVertical
  },
  {
    key = 'c',
    mods = 'LEADER',
    action = wezterm.action.SpawnTab "CurrentPaneDomain"
  },
  {
    key = 'p',
    mods = 'LEADER',
    action = wezterm.action.ActivateTabRelative(-1)
  },
  {
    key = 'n',
    mods = 'LEADER',
    action = wezterm.action.ActivateTabRelative(1)
  },
  {
    key = 'q',
    mods = 'LEADER',
    action = wezterm.action.CloseCurrentTab { confirm = true }
  },
  {
    key = 'f',
    mods = 'LEADER',
    action = wezterm.action.Search { CaseSensitiveString = "" }
  },
  {
    key = 'c',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.CopyTo "Clipboard"
  },
  {
    key = 'v',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.PasteFrom "Clipboard"
  },
}

for i = 0, 9, 1
do
  local key = {
    key = tostring(i),
    mods = 'LEADER',
    action = wezterm.action.ActivateTab(i)
  }
  table.insert(keys, key)
end

local config = wezterm.config_builder()
config.font = wezterm.font 'JetBrains Mono'
config.window_decorations = "NONE"
config.leader = { key = 'b', mods = 'CTRL', timeout_milliseconds = 1000 }
config.audible_bell = "Disabled"
config.disable_default_key_bindings = true
config.keys = keys
config.tab_bar_at_bottom = true
config.window_background_opacity = 0.6

config.colors = {
  tab_bar = {
    background = "rgba(0, 0, 0, 0)",
  }
}

config.use_fancy_tab_bar = false;
config.show_new_tab_button_in_tab_bar = false;

wezterm.on("gui-startup", function(cmd)
  local mux = wezterm.mux
  local _, _, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

wezterm.on(
  'format-tab-title',
  -- function(tab, tabs, panes, _config, hover, max_width)
  function(tab, _, _, _, _, _)
    local title = tab.tab_title
    if title and #title > 0 then
      return title
    end
    return tab.tab_index .. ': ' .. tab.active_pane.title .. ' '
  end
)


return config
