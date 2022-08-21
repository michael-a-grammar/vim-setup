return function()
  local set = require'keymappings.helpers'.nx_leader_with('z')

  set('e', '<cmd>edit $MYVIMRC<cr>',   'Edit profile')
  set('z', '<cmd>source $MYVIMRC<cr>', 'Source profile')
end
