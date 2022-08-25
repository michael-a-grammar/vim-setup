return function()
  local set = require'milque.cartographer'.nx_leader

  set('F', '<c-i>', 'Forwards')
  set('P', '<c-o>', 'Backwards')
end
