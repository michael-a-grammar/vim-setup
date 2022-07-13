return function()
  local map = require'milque.cartographer'.with.nx_leader_t

  map()
    .use('c')
    .rhs
      .cmd_new()
    .exe()

  map()
    .use('d')
    .rhs
      .cmd_bdelete()
    .exe()

  map()
    .use('n')
    .rhs
      .cmd_bnext()
    .exe()

  map()
    .use('p')
    .rhs
      .cmd_bprevious()
    .exe()

  map()
    .use('w')
    .rhs
      .cmd_ball()
    .exe()

  map()
    .use('y')
    .rhs
      .cmd_tab_ball()
  .exe()
end
