return function(config)
  local opts  = require'globals.opts'()
  local dev   = require'globals.dev'()
  local paths = require'globals.paths'()

  local M = opts.merged_opts

  M._opts  = opts
  M.dev    = dev
  M.config = config
  M.paths  = paths

  _G.E = M

  return M
end
