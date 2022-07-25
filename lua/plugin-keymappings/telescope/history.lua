return function()
  local telescope    = require'telescope.builtin'
  local cartographer = require'milque.cartographer'
  local map          = cartographer.with.nx_leader
  local t            = cartographer.with.nx_leader_T

  map()
  .use(',')
  .rhs
  .fn(telescope.quickfixhistory)
  .exe()

  map()
  .use('.')
  .rhs
  .fn(telescope.pickers)
  .exe()

  map()
  .use(':')
  .rhs
  .fn(telescope.command_history)
  .exe()

  map()
  .use(';')
  .rhs
  .fn(telescope.search_history)
  .exe()

  t()
  .rhs
  .fn(telescope.resume)
  .exe()
end
