return function()
  local map = require'milque.cartographer'.nx_leader

  local function z()
    return map().use_z()
  end

  z()
    .use_e()
    .rhs
      .cmd('edit $MYVIMRC')
  .exe()

  z()
    .use_z()
    .rhs
      .cmd('source $MYVIMRC')
  .exe()
end
