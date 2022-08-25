return function()
  local set = require'milque.cartographer'.i

  set('', '<c-w>', 'Delete words backwards')
  set('jj', '<esc>', 'Return to normal mode')
end
