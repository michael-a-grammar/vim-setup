return function()
  local map = require'milque.cartographer'.with['n_leader_/']

  map()
  .use('S')
  .rhs
  .fn(':%s/')
  .exe()

  map()
  .use_s()
  .rhs
  .fn(':s/')
  .exe()
end
