return function()
  local telescope = require'telescope.builtin'
  local set       = require'milque.cartographer'.nx_leader_with('e')

  set('e', telescope.diagnostics, 'Diagnostics')
end
