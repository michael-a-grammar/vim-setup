return function()
  local x = require'milque.cartographer'.with.nx_leader_x

  x()
    .use_a()
    .rhs
      .plug('EasyAlign')
    .exe()
end
