return function()
  local fn        = vim.fn
  local getenv    = os.getenv
  local normalize = vim.fs.normalize
  local M         = {}

  local get_path = function(varname, default)
    local path = getenv(varname) or default

    return normalize(path)
  end

  local elden_path      = get_path('ELDEN_PATH')
  local vim_config_path = get_path('XDG_CONFIG_PATH', '~/.config')

  M.data_path       = fn.stdpath('data')
  M.elden_path      = elden_path
  M.vim_config_path = vim_config_path

  return M
end
