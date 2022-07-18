return function()
  local x = require'milque.cartographer'.with.nx_leader_x

  x()
    .use_u()
    .rhs
      .cmd('GundoToggle')
    .exe()
end
