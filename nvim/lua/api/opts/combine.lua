return function(default_opts, user_opts, dev_opts)
  local M = {}

  user_opts = (user_opts and type(user_opts) == 'table') or {}

  merge_opts = function(opts1, opts2)
    return vim.tbl_deep_extend('force', opts1, opts2)
  end

  local merged_opts = merge_opts(default_opts, user_opts)

  if default_opts.is_dev then
    dev_opts.is_dev = true
    merged_opts     = merge_opts(merged_opts, dev_opts)
  end

  M.default = default_opts
  M.user    = user_opts
  M.dev     = dev_opts
  M.merged  = merged_opts

  return M
end
