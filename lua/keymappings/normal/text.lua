return function()
  local set = require'keymappings.helpers'.nx_leader_with('x')

  set('m', '<c-a>',     'Increment')
  set('M', '<c-x>',     'Decrement')
  set('s', ':sort<cr>', 'Sort')
end
