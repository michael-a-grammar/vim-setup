return function()
  local p = require'milque.cartographer'.with.nx_leader_p

  p()
  .use_N()
  .rhs
  .plug('miniyank-cycleback')
  .exe()

  p()
  .use_P()
  .rhs
  .plug('miniyank-startPut')
  .exe()

  p()
  .use_n()
  .rhs
  .plug('miniyank-cycle')
  .exe()

  p()
  .use_p()
  .rhs
  .plug('miniyank-startput')
  .exe()
end
