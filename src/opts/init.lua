local default_opts  = require'elden.opts.default'
local _, user_opts  = pcall(require, 'elden-user-opts')
local dev_opts      = require'elden.opts.dev'
local combined_opts = require'elden.opts.combine'(default_opts, user_opts, dev_opts)

local M = combined_opts.merged

M.default_opts = combined_opts.default
M.user_opts    = combined_opts.user
M.dev_opts     = combined_opts.dev

return M
