return function()
  local map = require'milque.cartographer'.with.nx_leader_x

  map()
    .use_M()
    .rhs
      .fn('<c-x>')
    .exe()

  map()
    .use_a()
    .rhs
      .plug('EasyAlign')
    .exe()

  map()
    .use_m()
    .rhs
      .fn('c-a')
    .exe()

  map()
    .use_u()
    .rhs
      .cmd('GundoToggle')
    .exe()

  map()
    .use_s()
    .rhs
      .fn(':sort<cr>')
    .exe()
end
