local plugin_providers = {}

function plugin_providers.get(opts, name, module)
  local provider = 'plugin-providers.' .. name .. '.' .. module
  local map      = {}

  for key1, val1 in pairs(provider) do
    if opts.use[key1] then
      for key2, value2 in pairs(val1) do
        map[key2] = val2
      end
    end
  end

  local function noop()
    return false
  end

  return setmetatable(map, {
    __index = function()
      return noop
    end
  })
end

return plugin_providers
