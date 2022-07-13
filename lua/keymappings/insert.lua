return function()
  local map = require'milque.cartographer'.with.i

  map()
    .use('')
    .rhs
      .fn('<c-w>')
    .exe()

  map()
    .use('jj')
    .rhs
      .fn('<esc>')
    .exe()
end
