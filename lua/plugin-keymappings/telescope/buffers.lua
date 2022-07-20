return function()
  local t         = require'milque.cartographer'.with.nx_leader_t
  local telescope = require'telescope.builtin'

  t()
  .use_t()
  .rhs
  .fn(telescope.buffers)
  .exe()
end
