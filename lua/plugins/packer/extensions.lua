return function(globals)
  local packer = globals.packer
  local M      = {}

  local plugin_disabled = function(plugin)
    for _, disabled_plugin in ipairs(globals.disabled_plugins) do
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

    local config_path =
      packer.relative_plugins_config_path .. stripped

    local success, module = pcall(require, config_path)

    if success then
      return function()
        module(globals)
      end
    end
  end

  local make_spec = function(spec, opts)
    local plugin, merge_spec

    local is_local    = opts.is_local    or false
    local with_config = opts.with_config or false

    local create_plugin = function(plugin)
      if is_local then
        return globals.dev_path .. plugin
      end

      return plugin
    end

    if type(spec) == 'table' then
      plugin      = create_plugin(spec[1])
      merge_spec  = spec
    else
      plugin      = create_plugin(spec)
      merge_spec  = {
        plugin
      }
    end

    local disable = plugin_disabled(plugin)

    local new_spec = {
      disable = disable
    }

    if with_config then
      new_spec.config = plugin_config(plugin)
    end

    return vim.tbl_deep_extend('error', merge_spec, new_spec)
  end

  M.create = function(use)
    local create_use_spec = function(opts)
      return function(spec)
        use(make_spec(spec, opts))
      end
    end

    local use_spec = create_use_spec({
      with_config = true
    })

    local local_use_spec = create_use_spec({
      is_local    = true,
      with_config = true
    })

    local local_use = create_use_spec({
      is_local = true
    })

    return {
      use_spec       = use_spec,
      local_use_spec = local_use_spec,
      local_use      = local_use
    }
  end

  return M
end
