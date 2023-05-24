return function(config)
  local log                 = require'start.log'()
  local success, local_opts = pcall(require, 'local-opts')
  local default_opts        = require'start.default-opts'
  local opts                = require'start.opts'(success, local_opts, default_opts)
  local paths               = require'start.paths'(config)

  local env = opts.merged_opts

  env.default_opts = opts.default_opts
  env.local_opts   = opts.local_opts

  env.config = config
  env.log    = log
  env.paths  = paths

  _G.E = env

  require'settings'(env)
  require'plugins'(env)
  require'settings.after-plugins'(env)
  require'elden'(env)
end
