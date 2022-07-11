return function()
  local map = require'milque.cartographer'.nx_leader

  local function y()
    return map().use_y()
  end

  y()
    .use_c()
    .rhs
      .cmd_tabnew()
  .exe()

  y()
    .use_d()
    .rhs
      .cmd_tabclose()
  .exe()

  y()
    .use_f()
    .rhs
      .cmd_tabfirst()
  .exe()

  y()
    .use_l()
    .rhs
      .cmd_tablast()
  .exe()

  y()
    .use_n()
    .rhs
      .cmd_tabnext()
  .exe()

  y()
    .use_p()
    .rhs
      .cmd_tabprevious()
  .exe()
end
