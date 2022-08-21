return function()
  local set = require'keymappings.helpers'.nx_leader

  set('F', '<c-i>', 'Forwards')
  set('P', '<c-o>', 'Backwards')
end
