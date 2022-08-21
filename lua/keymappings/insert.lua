return function()
  local set = require'keymappings.helpers'.i

  set('', '<c-w>', 'Delete words backwards')
  set('jj', '<esc>', 'Return to normal mode')
end
