local opts   = require'globals.opts'()
local values = require'globals.values'(opts.extended_opts)
local dev    = require'globals.dev'(values)

local M = vim.tbl_deep_extend('force', opts.extended_opts, values)

M._opts = opts

_G.D = dev
_G.E = M

return M
