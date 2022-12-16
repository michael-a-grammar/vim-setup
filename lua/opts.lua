local opts       = require'elden-opts'
local local_opts = require'elden-opts-local'

return vim.tbl_deep_extend('force', opts, local_opts)
