return function()
  local set = require'milque.cartographer'.nvo_with','

  set('/', '<plug>(easymotion-sn)',   'Search')
  set('n', '<plug>(easymotion-next)', 'Next result')
  set('N', '<plug>(easymotion-prev)', 'Previous result')

  set('a', '<plug>(easymotion-lineanywhere)',   'Line anywhere')
  set('A', '<plug>(easymotion-jumptoanywhere)', 'Jump to anywhere')

  set('f', '<plug>(easymotion-bd-f)',  'Find char forward')
  set('F', '<plug>(easymotion-bd-fl)', 'Find char bidirectional')

  set('t', '<plug>(easymotion-bd-t)',  'Til char forward')
  set('T', '<plug>(easymotion-bd-tl)', 'Til char bidirectional')

  set('<up>',    '<plug>(easymotion-k)',            'Jump to line upwards')
  set('<right>', '<plug>(easymotion-lineforward)',  'Jump word forward')
  set('<down>',  '<plug>(easymotion-j)',            'Jump to line downwards')
  set('<left>',  '<plug>(easymotion-linebackward)', 'Jump word backwards')

  set('sf', '<plug>(easymotion-overwin-f)',    'Over-window find char')
  set('sF', '<plug>(easymotion-overwin-f2)',   'Over-window find char (2)')
  set('sl', '<plug>(easymotion-overwin-line)', 'Over-window jump to line')
  set('ss', '<plug>(easymotion-s2)',           'Sneak (2)')
  set('sw', '<plug>(easymotion-overwin-w)',    'Over-window jump to word')
end
