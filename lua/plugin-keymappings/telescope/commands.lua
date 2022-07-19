return function()
  local map       = require'milque.cartographer'.with.nx_leader
  local telescope = require'telescope.builtin'

  map()
  .use(':')
  .rhs
  .fn(telescope.command_history)
  .exe()

  map()
  .use(';')
  .rhs
  .fn(telescope.commands)
  .exe()
end
