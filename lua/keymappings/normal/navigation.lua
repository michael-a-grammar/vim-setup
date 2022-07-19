return function()
  local f = require'milque.cartographer'.with.nx_leader_F
  local p = require'milque.cartographer'.with.nx_leader_P

  f()
    .rhs
      .fn('<c-i>')
    .exe()

  p()
    .rhs
      .fn('<c-o>')
    .exe()
end
