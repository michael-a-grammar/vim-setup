return function(global_opts)
  local fn = vim.fn
  local M  = {}

  local config_path  = fn.stdpath('config')
  local dev_path     = global_opts.dev_path or ''
  local has_dev_path = dev_path and vim.fn.isdirectory(dev_path)

  local join_path = function(tree)
    return function(leaf)
      return tree .. '/' .. leaf
    end
  end

  local join_config_path = join_path(config_path)

  M.config_path   = config_path
  M.data_path     = fn.stdpath('data')
  M.dev_path      = dev_path
  M.has_dev_path  = has_dev_path
  M.lua_path      = join_config_path('lua')
  M.init_path     = join_config_path('init.lua')
  M.plugins_path  = join_config_path('plugin')

  if has_dev_path then
    local join_dev_path = join_path(dev_path)

    M.lua_dev_path  = join_dev_path('lua')
    M.init_dev_path = join_dev_path('init.lua')
  end

  return M
end
