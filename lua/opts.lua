local toggles = {
  themes  = {},
  plugins = {}
}

local themes = {
  'alduin',
  'dogrun',
  'dracula',
  'fogbell',
  'fogbell_light',
  'fogbell_lite',
  'gotham',
  'iceberg',
  'jellybeans',
  'kolor',
  'noir',
  'nord',
  'orbital',
  'solarized',
  'solarized8',
  'solarized8_flat',
  'solarized8_high',
  'solarized8_low',
  'sononkai',
  'spacecamp',
  'spacecamp_lite',
  'sunbather',
  'tender',
  ['PaperColor']',
  ['challenger-deep-theme'],
  ['pink-moon']',
}

local plugins = {
  'airline',
  'cmp',
  'dracula',
  'elixir_nvim',
  'elixir_lsp',
  'lsp',
  'tender',
  'which_key'
}

for _, theme in ipairs(themes) do
  toggles.use.themes[theme] = false
end

for _, plugin in ipairs(plugins) do
  toggles.use.plugins[plugin] = false
end

toggles.get_theme = function()
  for theme, use in pairs(toggles.themes) do
    if use then
      return theme
    end
  end
end

toggles.set_theme = function(theme)
  if toggles.themes[theme] == false then
    toggles.themes[theme] = true
  end
  return toggles
end

toggles.with_plugins = function(plugins)
  for _, plugin in ipairs(plugins) do
    if toggles.plugins[plugin] == false then
      toggles.plugins[plugin] = true
    end
  end
  return toggles
end

toggles.use_plugin = setmetatable({}, {
  __index = function(tbl, key)
    if not toggles.plugins[key] then
      return false
    end

    return true
  end
})

return toggles
