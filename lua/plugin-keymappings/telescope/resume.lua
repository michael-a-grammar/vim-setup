return function()
  local t         = require'milque.cartographer'.with.nx_leader_T
  local telescope = require'telescope.builtin'

  t()
  .rhs
  .fn(telescope.resume)
  .exe()
end
