return function()
  local local_opts   = require'local-opts'
  local default_opts = require'globals.default-opts'
  local M            = {}

  local merged_opts = vim.tbl_deep_extend('force', default_opts, local_opts)

  M.default_opts = default_opts
  M.local_opts   = local_opts
  M.merged_opts  = merged_opts

  return M
end
