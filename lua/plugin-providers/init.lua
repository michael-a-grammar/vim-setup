local plugin_providers = {}

function plugin_providers.cartographer(map)
  rawset(map.rhs, 'use_provider', function(rhs)
    return map.rhs
  end)
end

function plugin_providers.get(opts, plugin, functionality)
  local req    = 'plugin-providers.' .. plugin '.' .. functionality
  local lsp, _ = pcall(require, req .. '.lsp')
  local coc, _ = pcall(require, req .. '.coc')
  local map    = {}

  if lsp then
    for key, value in pairs(lsp) do
      map[key] = value
    end
  end

  if opts.use.coc and coc then
    for key, value in pairs(coc) do
      map[key] = value
    end
  end

  if not #map > 0 then
    return map
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
