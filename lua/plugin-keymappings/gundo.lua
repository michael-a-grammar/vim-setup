return function()
  local set = require'milque.cartographer'.nx_leader_with('x')

  set('u', '<cmd>GundoToggle<cr>', 'Undo history')
end
