return function()
  local map = require'milque.cartographer'.with.nx

  map()
    .use(',,')
    .rhs
      .fn(',')
    .exe()

  map()
    .use('$')
    .rhs
      .fn('g$')
    .exe()

  map()
    .use('0')
    .rhs
      .fn('g0')
    .exe()

  map()
    .use('^')
    .rhs
      .fn('g^')
    .exe()

  map()
    .use('H')
    .rhs
      .fn('g^')
    .exe()

  map()
    .use('L')
    .rhs
      .fn('g$')
    .exe()

  map()
    .use('N')
    .rhs
      .fn('Nzzzv')
    .exe()

  map()
    .use('n')
    .rhs
      .fn('nzzzv')
    .exe()

  map()
    .use_alt('left')
    .rhs
      .fn('<c-u>')
    .exe()

  map()
    .use_alt('right')
    .rhs
      .fn('<c-d>')
    .exe()

  map()
    .use('-')
    .rhs
      .fn('ddp')
    .exe()

  map()
    .use('_')
    .rhs
      .fn('dd<up>P')
    .exe()
end
