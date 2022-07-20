return function(opts)
  local d           = require'milque.cartographer'.with.nx_leader_d
  local pp          = require'plugin-providers'
  local definitions = pp.get(opts, 'lsp', 'definitions')

  d()
  .use_h()
  .rhs
  .provider(definitions.hover)
  .exe()

  d()
  .use_s()
  .rhs
  .provider(definitions.signature)
  .exe()
end
