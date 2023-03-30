local opts  = require'globals.opts'()
local dev   = require'globals.dev'()
local paths = require'globals.paths'()

local M = opts.extended_opts

M._opts = opts
M.dev   = dev
M.paths = paths

_G.E = M

return M
