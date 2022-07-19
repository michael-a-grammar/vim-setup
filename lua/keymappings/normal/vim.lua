return function()
  local z = require'milque.cartographer'.with.nx_leader_z

  z()
  .use_e()
  .rhs
  .cmd('edit $MYVIMRC')
  .exe()

  z()
  .use_z()
  .rhs
  .cmd('source $MYVIMRC')
  .exe()
end
