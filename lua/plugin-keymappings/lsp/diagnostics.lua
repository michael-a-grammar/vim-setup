return function(opts)
  local e           = require'milque.cartographer'.with.nx_leader_e
  local pp          = require'plugin-providers'
  local diagnostics = pp.get(opts, 'lsp', 'diagnostics')

  e()
  .use_N()
  .rhs
  .provider(diagnostics.next)
  .exe()

  e()
  .use_P()
  .rhs
  .provider(diagnostics.prev)
  .exe()

  e()
  .use_c()
  .rhs
  .provider(diagnostics.setloclist)
  .exe()

  e()
  .use_d()
  .rhs
  .provider(diagnostics.info)
  .exe()

  e()
  .use_n()
  .rhs
  .provider(diagnostics.next_error)
  .exe()

  e()
  .use_p()
  .rhs
  .provider(diagnostics.prev_error)
  .exe()

  e()
  .use_r()
  .rhs
  .provider(diagnostics.refresh)
  .exe()
end
