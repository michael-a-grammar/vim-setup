return function()
  local map = require'milque.cartographer'.with.nx_leader_w

  map()
    .use('=')
    .rhs
      .fn('<c-w>=')
    .exe()

  map()
    .use_E()
    .rhs
      .fn('<c-w>J')
    .exe()

  map()
    .use_I()
    .rhs
      .fn('<c-w>K')
    .exe()

  map()
    .use_N()
    .rhs
      .fn('<c-w>H')
    .exe()

  map()
    .use_O()
    .rhs
      .fn('<c-w>L')
    .exe()

  map()
    .use_R()
    .rhs
      .fn('<c-w>R')
    .exe()

  map()
    .use_S()
    .rhs
      .cmd('split')
    .exe()

  map()
    .use_d()
    .rhs
      .cmd('close')
    .exe()

  map()
    .use_e()
    .rhs
      .fn('<c-w>j')
    .exe()

  map()
    .use_h()
    .rhs
      .cmd('only')
    .exe()

  map()
    .use_i()
    .rhs
      .fn('<c-w>k')
    .exe()

  map()
    .use_n()
    .rhs
      .fn('<c-w>h')
    .exe()

  map()
    .use_o()
    .rhs
      .fn('<c-w>l')
    .exe()

  map()
    .use_r()
    .rhs
      .fn('<c-w>r')
    .exe()

  map()
    .use_s()
    .rhs
      .cmd('vsplit')
    .exe()

  map()
    .use_t()
    .rhs
      .cmd('tab split')
    .exe()
end
