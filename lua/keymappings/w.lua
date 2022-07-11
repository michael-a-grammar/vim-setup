return function()
  local map = require'milque.cartographer'.nx_leader

  local function w()
    return map().use_w()
  end

  w()
    .use('=')
    .rhs
      .fn('<c-w>=')
  .exe()

  w()
    .use('E')
    .rhs
      .fn('<c-w>J')
  .exe()

  w()
    .use('I')
    .rhs
      .fn('<c-w>K')
  .exe()

  w()
    .use('N')
    .rhs
      .fn('<c-w>H')
  .exe()

  w()
    .use('O')
    .rhs
      .fn('<c-w>L')
  .exe()

  w()
    .use('R')
    .rhs
      .fn('<c-w>R')
  .exe()
end
