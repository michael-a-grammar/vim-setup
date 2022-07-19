return function(opts)
  local lsp = require'plugin-keymappings.providers.lsp'
  local coc = require'plugin-keymappings.providers.coc'
  local map = {}

  for key, value in pairs(lsp) do
    map[key] = value
  end

  if opts.use.coc then
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
