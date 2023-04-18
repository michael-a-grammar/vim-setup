return function(config)
  local opts  = require'elden.opts'()
  local log   = require'elden.log'()
  local paths = require'elden.paths'(config)

  local M = opts.merged_opts

  M.default_opts = opts.default_opts
  M.local_opts   = opts.local_opts

  M.config = config
  M.log    = log
  M.paths  = paths

  _G.E = M

  return M
end
