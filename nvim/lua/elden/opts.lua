return function()
  local success, local_opts = pcall(require, 'local-opts')
  local default_opts        = require'elden.default-opts'
  local M                   = {}

  local_opts = (success and local_opts) or {}

  local merged_opts = vim.tbl_deep_extend('force', default_opts, local_opts)

  M.default_opts = default_opts
  M.local_opts   = local_opts
  M.merged_opts  = merged_opts

  return M
end
