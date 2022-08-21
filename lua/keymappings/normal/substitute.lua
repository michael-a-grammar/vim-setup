return function()
  local set = require'keymappings.helpers'.nx_leader_with('/')

  set('s', ':s/', 'Substitute within line')
  set('S', ':%s/',  'Substitute')
end
