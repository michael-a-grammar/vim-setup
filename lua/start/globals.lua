local fn    = vim.fn
local opts   = vim.g.elden.opts
local elden = vim.g.elden

if elden.globals == nil then
  local globals = {
    config_path = fn.stdpath('config'),
    dev_path    = opts.dev_path
  }
end

return elden.globals
