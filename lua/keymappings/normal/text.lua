return function()
  local x = require'milque.cartographer'.with.nx_leader_x

  x()
  .use_M()
  .rhs
  .fn('<c-x>')
  .exe()

  x()
  .use_m()
  .rhs
  .fn('c-a')
  .exe()

  x()
  .use_s()
  .rhs
  .fn(':sort<cr>')
  .exe()
end
