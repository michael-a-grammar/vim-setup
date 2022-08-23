return function()
  local set = require'keymappings.helpers'.nx_leader_with('x')

  set('a', '<plug>(EasyAlign)', 'Align')
end
