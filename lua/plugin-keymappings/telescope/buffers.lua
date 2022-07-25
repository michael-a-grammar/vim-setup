return function()
  local telescope = require'telescope.builtin'
  local t         = require'milque.cartographer'.with.nx_leader_t

  t()
  .use_t()
  .rhs
  .fn(telescope.buffers)
  .exe()
end
