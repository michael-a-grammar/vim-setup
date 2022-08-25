return function()
  local telescope = require'telescope.builtin'
  local set       = require'milque.cartographer'.nx_leader_with('t')

  set('t', telescope.buffers, 'Buffers')
end
