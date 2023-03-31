return function(config)
  local globals = require'globals'(config)

  require'settings'(globals)
  require'plugins'(globals)
  require'settings.after-plugins'(globals)
end
