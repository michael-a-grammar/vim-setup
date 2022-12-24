local fn = vim.fn

if elden.globals == nil then
  local globals = {
    config_path = fn.stdpath('config'),
    dev_path    = elden.opts.dev_path
  }

  elden.globals = globals
end

return elden.globals
