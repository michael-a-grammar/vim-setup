return function()
  local set = require'keymappings.helpers'.nvo_with(',')

  set('/', '<plug>(easymotion-sn)',   'Search')
  set('n', '<plug>(easymotion-next)', 'Next result')
  set('N', '<plug>(easymotion-prev)', 'Previous result')

  set('a', '<plug>(easymotion-lineanywhere)',   'Line anywhere')
  set('A', '<plug>(easymotion-jumptoanywhere)', 'Jump to anywhere')

  set('f', '<plug>(easymotion-bd-f)',  'Find line forward')
  set('F', '<plug>(easymotion-bd-fl)', 'Find line bidirectional')

  set('t', '<plug>(easymotion-bd-t)', 'Til line forward')
  set('T', '<plug>(easymotion-bd-tl)', 'Til line bidirectional')

  set('<up>',    '<plug>(easymotion-k)',            'Jump up')
  set('<right>', '<plug>(easymotion-lineforward)',  'Jump forward')
  set('<down>',  '<plug>(easymotion-j)',            'Jump down')
  set('<left>',  '<plug>(easymotion-linebackward)', 'Jump left')


  set('SF', '<plug>(easymotion-overwin-f2)', '')

  set('Sf', '<plug>(easymotion-overwin-f)', '')

  set('Sl', '<plug>(easymotion-overwin-line)', '')

  set('Sw', '<plug>(easymotion-overwin-w)', '')



  set('ke', '<plug>(easymotion-iskeyword-bd-e)', '')

  set('kw', '<plug>(easymotion-iskeyword-bd-w)', '')






  set('sS', '<plug>(easymotion-s)', '')

  set('sW', '<plug>(easymotion-bd-w)', '')


  set('se', '<plug>(easymotion-bd-el)', '')

  set('sf', '<plug>(easymotion-bd-f2)', '')


  set('ss', '<plug>(easymotion-s2)', '')

  set('st', '<plug>(easymotion-bd-t2)', '')

  set('sw', '<plug>(easymotion-bd-wl)', '')

end
