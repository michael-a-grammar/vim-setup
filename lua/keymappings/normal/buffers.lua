return function()
  local t = require'milque.cartographer'.with.nx_leader_t

  t()
    .use_c()
    .rhs
      .cmd_new()
    .exe()

  t()
    .use_d()
    .rhs
      .cmd_bdelete()
    .exe()

  t()
    .use_n()
    .rhs
      .cmd_bnext()
    .exe()

  t()
    .use_p()
    .rhs
      .cmd_bprevious()
    .exe()

  t()
    .use_w()
    .rhs
      .cmd_ball()
    .exe()

  t()
    .use_y()
    .rhs
      .cmd_tab_ball()
    .exe()
end
