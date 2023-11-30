local default_opts  = require'default-opts'
local _, user_opts  = pcall(require, 'local-opts')
local dev_opts      = require'dev-opts'
local combined_opts = require'api.opts.combine'(default_opts, user_opts, dev_opts)

local M = combined_opts.merged

M.default_opts = combined_opts.default
M.user_opts    = combined_opts.user
M.dev_opts     = combined_opts.dev

return M
