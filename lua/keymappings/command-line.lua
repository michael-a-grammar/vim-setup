return function()
  local set = require'keymappings.helpers'.c

  set('',        '<c-w>',     'Delete word backwards') 
  set('<a-left>',  '<c-left>',  'Word backwards')
  set('<a-right>', '<c-right>', 'Word forwards')
end
