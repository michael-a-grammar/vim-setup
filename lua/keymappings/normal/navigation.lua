return function()
  local p = require'milque.cartographer'.with.nx_leader_P

  p()
    .rhs
      .fn('<c-o>')
    .exe()
end
