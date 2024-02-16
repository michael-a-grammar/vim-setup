local log    = require'elden.log'
local opts   = require'elden.opts'
local paths  = require'elden.paths'
local packer = opts.packer

local is_plugin_disabled = function(plugin_path)
  for _, disabled_plugin in ipairs(opts.disabled_plugins) do
    if disabled_plugin:match('%s') ~= nil and plugin_path:find(disabled_plugin, 1, true) ~= nil then
      return true
    end
  end
  return false
end

local get_plugin_config = function(plugin_path, plugin_name)
  local values_to_strip_from_plugin_config_name = {
    '.*/',
    '%.nvim',
    '%-nvim',
    'nvim%.',
    'nvim%-',
    '%.vim',
    '%-vim',
    'vim%.',
    'vim%-',
  }

  local plugin_config_name = plugin_name or plugin_path

  if not plugin_name then
    for _, value_to_strip_from_plugin_config_name in ipairs(values_to_strip_from_plugin_config_name) do
      plugin_config_name =
        plugin_config_name:gsub(value_to_strip_from_plugin_config_name, '')
    end
  end

  local plugin_config_path =
    packer.relative_plugins_config_path .. '.' .. plugin_config_name

  local success, module = pcall(require, plugin_config_path)

  log('plugin config retrieved', {
    plugin_config_name = plugin_config_name,
    plugin_config_path = plugin_config_path,
    success            = success,
  })

  return module
end

local ensure_plugin_path = function(plugin_path, plugin_is_local)
  if plugin_is_local then
    return paths.bundled_plugins .. '/' .. plugin_path
  end

  return plugin_path
end

local create_plugin_spec = function(plugin_spec, plugin_spec_opts)
  local plugin_path, plugin_spec_to_extend, plugin_name

  local plugin_is_local   = plugin_spec_opts.is_local    or false
  local plugin_has_config = plugin_spec_opts.with_config or false

  if type(plugin_spec) == 'table' then
    plugin_path           = ensure_plugin_path(plugin_spec[1], plugin_is_local)
    plugin_name           = plugin_spec.as or nil
    plugin_spec_to_extend = plugin_spec
  else
    plugin_path = ensure_plugin_path(plugin_spec, plugin_is_local)
    plugin_name = nil

    plugin_spec_to_extend = {
      plugin_path,
    }
  end

  local plugin_is_disabled = is_plugin_disabled(plugin_path)

  local new_plugin_spec = {
    disable = plugin_is_disabled,
  }

  if plugin_has_config then
    new_plugin_spec.config = get_plugin_config(plugin_path, plugin_name)
  end

  return vim.tbl_deep_extend('error', plugin_spec_to_extend, new_plugin_spec)
end

return function(use)
  local create_use_plugin_spec = function(plugin_spec_opts)
    return function(plugin_spec)
      use(create_plugin_spec(plugin_spec, plugin_spec_opts))
    end
  end

  local plugin_spec = create_use_plugin_spec({
    with_config = true,
  })

  local local_plugin_spec = create_use_plugin_spec({
    is_local    = true,
    with_config = true,
  })

  local local_plugin = create_use_plugin_spec({
    is_local = true,
  })

  return {
    plugin_spec       = plugin_spec,
    local_plugin_spec = local_plugin_spec,
    local_plugin      = local_plugin,
  }
end
