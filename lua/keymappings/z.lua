return function()
  local map = require'milque.cartographer'.with.nx_leader_z

  map()
    .use_e()
    .rhs
      .cmd('edit $MYVIMRC')
  .exe()

  map()
    .use_z()
    .rhs
      .cmd('source $MYVIMRC')
  .exe()
end
