local toggles = {
  themes  = {},
  plugins = {}
}

local themes = {
  'PaperColor',
  'alduin',
  'challenger-deep-theme',
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
  'pink-moon',
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
}

local plugins = {
  'airline',
  'cmp',
  'elixir_nvim',
  'elixir_lsp',
  'lsp',
  'which_key'
}

for _, theme in ipairs(themes) do
  toggles.themes[theme] = false
end

for _, plugin in ipairs(plugins) do
  toggles.plugins[plugin] = false
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

toggles.use_theme = setmetatable({}, {
  __index = function(tbl, key)
    if not toggles.themes[key] then
      return false
    end

    return true
  end
})

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
