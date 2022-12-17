local opts       = require'elden-opts'
local local_opts = require'elden-opts-local'

local extended_opts = vim.tbl_deep_extend('force', opts, local_opts)

vim.g.elden = {}
vim.g.elden.opts = extended_opts

return extended_opts
