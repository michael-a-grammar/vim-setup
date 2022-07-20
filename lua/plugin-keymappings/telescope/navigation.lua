return function(opts)
  local n          = require'milque.cartographer'.with.nx_leader_n
  local pp         = require'plugin-providers'
  local navigation = pp.get(opts, 'telescope', 'navigation')

  n()
  .use_d()
  .rhs
  .provider(navigation.definitions)
  .exe()

  n()
  .use_i()
  .rhs
  .provider(navigation.implementations)
  .exe()

  n()
  .use_t()
  .rhs
  .provider(navigation.type_definitions)
  .exe()

  n()
  .use_u()
  .rhs
  .provider(navigation.references)
  .exe()
end
