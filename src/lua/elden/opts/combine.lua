return function(default_opts, user_opts, dev_opts)
  local combined_opts = {}

  user_opts = (user_opts and type(user_opts) == 'table') or {}

  local merge_opts = function(opts1, opts2)
    return vim.tbl_deep_extend('force', opts1, opts2)
  end

  local merged_opts = merge_opts(default_opts, user_opts)

  if default_opts.is_dev then
    dev_opts.is_dev = true
    merged_opts     = merge_opts(merged_opts, dev_opts)
  end

  combined_opts.default = default_opts
  combined_opts.user    = user_opts
  combined_opts.dev     = dev_opts
  combined_opts.merged  = merged_opts

  return combined_opts
end
