return function(has_local_opts, local_opts, default_opts)
  local M = {}

  local_opts = (has_local_opts and local_opts) or {}

  local merged_opts = vim.tbl_deep_extend('force', default_opts, local_opts)

  M.default_opts = default_opts
  M.local_opts   = local_opts
  M.merged_opts  = merged_opts

  return M
end
