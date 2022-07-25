return function()
  local cartographer = require'milque.cartographer'

  cartographer.with.nx_leader_L()
  .rhs
  .cmd('NERDTreeClose')
  .exe()

  cartographer.with.nx_leader_l()
  .rhs
  .cmd('NERDTreeFind')
  .exe()
end
