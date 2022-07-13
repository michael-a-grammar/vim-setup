return function()
  local map = require'milque.cartographer'.with.nx_leader_i

  map()
    .use_i()
    .rhs
      .plug('SlimeParagraphSend')
    .exe()

  map()
    .use_v()
    .rhs
      .plug('SlimeParagraphConfig')
    .exe()
end
