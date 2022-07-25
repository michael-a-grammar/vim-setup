return function()
  local telescope = require'telescope.builtin'
  local map       = require'milque.cartographer'.with.nx_leader

  map()
  .use(',')
  .rhs
  .fn(telescope.quickfixhistory)
  .exe()

  map()
  .use('.')
  .rhs
  .fn(telescope.pickers)
  .exe()

  map()
  .use(':')
  .rhs
  .fn(telescope.command_history)
  .exe()

  map()
  .use(';')
  .rhs
  .fn(telescope.search_history)
  .exe()
end
