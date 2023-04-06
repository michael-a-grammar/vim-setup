return function(config)
  local elden = require'elden'(config)

  require'settings'(elden)
  require'plugins'(elden)
  require'settings.after-plugins'(elden)
end
