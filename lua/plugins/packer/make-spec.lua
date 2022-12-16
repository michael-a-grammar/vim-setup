local opts = require'opts'

local disabled = function(plugin)
  for _, disabled_plugin in ipairs(opts.disabled_plugins) do
    if plugin:find(disabled_plugin, 1, true) ~= nil then
      return true
    end
  end
  return false
end

local with_config = function(plugin)
  local to_strip = {
    '.*/',
    '%.nvim',
    '%-nvim',
    'nvim%.',
    'nvim%-',
    '%.vim',
    '%-vim',
    'vim%.',
    'vim%-'
  }

  local stripped = plugin

  for _, strip in ipairs(to_strip) do
    stripped = stripped:gsub(strip, '')
  end

  local config_path = 'plugins.config.' .. stripped

  local success, module = pcall(require, config_path)

  if success then
    return module
  else
    print(module)
  end
end

local make_spec = function(spec)
  local plugin, merge_spec

  if type(spec) == 'table' then
    plugin      = spec[1]
    merge_spec  = spec
  else
    plugin      = spec
    merge_spec  = {
      plugin
    }
  end

  local config  = with_config(plugin)
  local disable = disabled(plugin)

  local new_spec = {
    config  = config,
    disable = disable
  }

  return vim.tbl_deep_extend('error', merge_spec, new_spec)
end

return make_spec
