return function()
  local map = require'milque.cartographer'.with.nx_leader_y

  map()
    .use_c()
    .rhs
      .cmd_tabnew()
    .exe()

  map()
    .use_d()
    .rhs
      .cmd_tabclose()
    .exe()

  map()
    .use_f()
    .rhs
      .cmd_tabfirst()
    .exe()

  map()
    .use_l()
    .rhs
      .cmd_tablast()
    .exe()

  map()
    .use_n()
    .rhs
      .cmd_tabnext()
    .exe()

  map()
    .use_p()
    .rhs
      .cmd_tabprevious()
    .exe()
end
