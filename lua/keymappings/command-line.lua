return function()
  local set = require'milque.cartographer'.c

  set('',        '<c-w>',     'Delete word backwards')
  set('<a-left>',  '<c-left>',  'Word backwards')
  set('<a-right>', '<c-right>', 'Word forwards')
end
