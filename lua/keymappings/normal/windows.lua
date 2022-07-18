return function()
  local w = require'milque.cartographer'.with.nx_leader_w

  w()
    .use('=')
    .rhs
      .fn('<c-w>=')
    .exe()

  w()
    .use_E()
    .rhs
      .fn('<c-w>J')
    .exe()

  w()
    .use_I()
    .rhs
      .fn('<c-w>K')
    .exe()

  w()
    .use_N()
    .rhs
      .fn('<c-w>H')
    .exe()

  w()
    .use_O()
    .rhs
      .fn('<c-w>L')
    .exe()

  w()
    .use_R()
    .rhs
      .fn('<c-w>R')
    .exe()

  w()
    .use_S()
    .rhs
      .cmd('split')
    .exe()

  w()
    .use_d()
    .rhs
      .cmd('close')
    .exe()

  w()
    .use_e()
    .rhs
      .fn('<c-w>j')
    .exe()

  w()
    .use_h()
    .rhs
      .cmd('only')
    .exe()

  w()
    .use_i()
    .rhs
      .fn('<c-w>k')
    .exe()

  w()
    .use_n()
    .rhs
      .fn('<c-w>h')
    .exe()

  w()
    .use_o()
    .rhs
      .fn('<c-w>l')
    .exe()

  w()
    .use_r()
    .rhs
      .fn('<c-w>r')
    .exe()

  w()
    .use_s()
    .rhs
      .cmd_vsplit()
    .exe()

  w()
    .use_t()
    .rhs
      .cmd_tab_split()
    .exe()
end
