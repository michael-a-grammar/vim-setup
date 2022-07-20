local plugin_providers = {}

function plugin_providers.get(opts, name, module)
  local provider = require('plugin-providers.' .. name .. '.' .. module)
  local map      = {}

  for key1, val1 in pairs(provider) do
    if opts.use[key1] then
      for key2, val2 in pairs(val1) do
        map[key2] = val2
      end
    end
  end

  local function noop(key)
    return function()
      print('Provider for ' .. key .. ' does not exist')
      return false
    end
  end

  return setmetatable(map, {
    __index = function(_, key)
      print('Provider for ' .. key .. ' does not exist')
      return noop(key)
    end
  })
end

return plugin_providers
