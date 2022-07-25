return function()
  local map = require'milque.cartographer'.with.i

  map()
  .use_ctrl('c')
  .rhs
  .plug('NERDCommenterInsert')
  .exe()
end
