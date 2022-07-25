return function()
  local telescope = require'telescope.builtin'
  local t       = require'milque.cartographer'.with.nx_leader_T

  t()
  .rhs
  .fn(telescope.resume)
  .exe()
end
