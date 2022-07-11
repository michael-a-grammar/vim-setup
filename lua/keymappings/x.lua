return function()
  local map = require'milque.cartographer'.nx_leader

  local function x()
    return map().use_x()
  end

  x()
    .use_M()
    .rhs
      .fn('<c-x>')
  .exe()

  x()
    .use_a()
    .rhs
      .plug('EasyAlign')
  .exe()

  x()
    .use_m()
    .rhs
      .fn('c-a')
    .exe()

  x()
    .use_u()
    .rhs
      .cmd('GundoToggle')
  .exe()

  x()
    .use_s()
    .rhs
      .fn(':sort<cr>')
  .exe()
end
