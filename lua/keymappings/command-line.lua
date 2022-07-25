return function()
  local map = require'milque.cartographer'.with.c

  map()
  .use('')
  .rhs
  .fn('<c-w>')
  .exe()

  map()
  .use_alt('left')
  .rhs
  .fn('<c-left>')
  .exe()

  map()
  .use_alt('right')
  .rhs
  .fn('<c-right')
  .exe()
end
