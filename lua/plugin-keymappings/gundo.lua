return function()
  local set = require'keymappings.helpers'.nx_leader_with('x')

  set('u', '<cmd>GundoToggle<cr>', 'Undo history')
end
