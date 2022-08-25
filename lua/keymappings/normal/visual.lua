return function()
  local set = require'milque.cartographer'.nx_leader_with('v')

  set('v', '<c-v>', 'Visual block')
end
