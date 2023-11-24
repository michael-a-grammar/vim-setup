return function(config)
  local fn        = vim.fn
  local getenv    = os.getenv
  local normalize = vim.fs.normalize
  local M         = {}

  local get_path = function(env_varname, default)
    local path = getenv(env_varname) or default

    if not path then
      return false
    end

    return normalize(path)
  end

  local elden_path      = get_path('ELDEN_PATH')
  local config_path     = get_path('XDG_CONFIG_PATH', '~/.config')
  local vim_config_path = config_path and config_path .. '/nvim' or false

  local get_bundled_plugins_path = function()
    local base_path = config.is_dev and elden_path or vim_config_path

    return base_path .. '/lua/bundled'
  end

  local bundled_plugins_path = get_bundled_plugins_path()

  M.data_path            = fn.stdpath('data')
  M.bundled_plugins_path = bundled_plugins_path
  M.elden_path           = elden_path
  M.vim_config_path      = vim_config_path

  return M
end
