return function()
  local getenv    = os.getenv
  local normalize = vim.fs.normalize
  local M         = {}

  local config_path            = getenv('XDG_CONFIG_PATH') or '~/.config'
  local dev_path               = getenv('ELDEN_PATH')
  local config_path_normalized = normalize(config_path .. '/nvim')
  local dev_path_normalized    = normalize(dev_path)

  M.config_path = config_path_normalized
  M.data_path   = fn.stdpath('data')
  M.dev_path    = dev_path_normalized

  return M
end
