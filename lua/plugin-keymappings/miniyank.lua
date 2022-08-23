return function()
  local set = require'keymappings.helpers'.nx_leader_with('p')

  set('n', '<plug>(miniyank-cycle)',     'Yank right forwards')
  set('N', '<plug>(miniyank-cycleback)', 'Yank ring backwards')
  set('p', '<plug>(miniyank-startput)',  'Yank ring put')
  set('P', '<plug>(miniyank-startPut)',  'Yank ring Put')
end
