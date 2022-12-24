local globals = elden.globals
local opts    = elden.opts

local M = {}

local plugin_disabled = function(plugin)
  for _, disabled_plugin in ipairs(opts.disabled_plugins) do
    if plugin:find(disabled_plugin, 1, true) ~= nil then
      return true
    end
  end
  return false
end

local plugin_config = function(plugin)
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

local make_spec = function(spec, opts)
  local plugin, merge_spec

  local is_local    = opts.is_local    or false
  local with_config = opts.with_config or false

  if type(spec) == 'table' then
    plugin      = spec[1]
    merge_spec  = spec
  else
    plugin      = spec
    merge_spec  = {
      plugin
    }
  end

  local disable = plugin_disabled(plugin)
  local config  = plugin_config(plugin)

  local new_spec = {
    config  = config,
    disable = disable
  }

  return vim.tbl_deep_extend('error', merge_spec, new_spec)
end

M.create_extensions = function(use)
  local use_spec = function(spec)
    use(make_spec(spec))
  end

  local local_use_spec = function(plugin)
    use(spec)
  end

  return {
    use_spec = use_spec,
    local_use_spec = local_use_spec
  }
end


return M
