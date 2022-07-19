local plugin_providers = {}

function plugin_providers.get(opts, plugin, functionality)
  local req         = 'plugin-providers.' .. plugin .. '.' .. functionality
  local ok_lsp, lsp = pcall(require, req .. '.lsp')
  local ok_coc, coc = pcall(require, req .. '.coc')
  local map         = {}

  if ok_lsp then
    for key, value in pairs(lsp) do
      map[key] = value
    end
  end

  if opts.use.coc and ok_coc then
    for key, value in pairs(coc) do
      map[key] = value
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
