return function()
  local set = require'milque.cartographer'.nx_leader_with'/'

  set('s', ':s/',  'Substitute within line')
  set('S', ':%s/', 'Substitute')
end
