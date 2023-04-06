return function(config)
  local opts  = require'globals.opts'()
  local dev   = require'globals.dev'()
  local log   = require'globals.log'()
  local paths = require'globals.paths'(config)

  local M = opts.merged_opts

  M.default_opts = opts.default_opts
  M.local_opts   = opts.local_opts

  M.dev    = dev
  M.config = config
  M.log    = log
  M.paths  = paths

  _G.E = M

  return M
end
