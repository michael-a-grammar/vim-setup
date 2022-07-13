return function()
  local map = require'milque.cartographer'.with['n_leader_/']

  map()
    .use('/')
    .rhs
      .fn(':%s/')
    .exe()

  map()
    .use('R')
    .rhs
      .cmd('call ReplaceCurrentWORD()')
    .exe()

  map()
    .use('i')
    .rhs
      .cmd('set noincsearch')
    .exe()

  map()
    .use('r')
    .rhs
      .cmd('call ReplaceCurrentWord()')
    .exe()

  map()
    .use('s')
    .rhs
      .fn(':s/')
    .exe()

  map()
    .use('t')
    .rhs
      .cmd('nohlsearch')
    .exe()
end
