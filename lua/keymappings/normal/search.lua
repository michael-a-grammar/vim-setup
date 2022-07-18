return function()
  local map = require'milque.cartographer'.with['n_leader_/']

  map()
    .use('/')
    .rhs
      .fn(':%s/')
    .exe()

  map()
    .use_R()
    .rhs
      .cmd('call ReplaceCurrentWORD()')
    .exe()

  map()
    .use_i()
    .rhs
      .cmd('set noincsearch')
    .exe()

  map()
    .use_r()
    .rhs
      .cmd('call ReplaceCurrentWord()')
    .exe()

  map()
    .use_s()
    .rhs
      .fn(':s/')
    .exe()

  map()
    .use_t()
    .rhs
      .cmd('nohlsearch')
    .exe()
end
