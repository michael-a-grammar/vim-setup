return function()
  local map = require'milque.cartographer'.with.nx_leader_P

  map()
    .rhs
      .fn('<c-o>')
    .exe()
end
