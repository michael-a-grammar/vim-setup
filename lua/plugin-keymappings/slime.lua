return function()
  local i = require'milque.cartographer'.with.nx_leader_i

  i()
  .use_i()
  .rhs
  .plug('SlimeParagraphSend')
  .exe()

  i()
  .use_v()
  .rhs
  .plug('SlimeParagraphConfig')
  .exe()
end
