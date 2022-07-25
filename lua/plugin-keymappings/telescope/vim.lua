return function()
  local telescope = require'telescope.builtin'
  local z         = require'milque.cartographer'.with.nx_leader_z

  z()
  .use(':')
  .rhs
  .fn(telescope.commands)
  .exe()
end
