return function()
  local set = require'keymappings.helpers'.nx_leader_with(',')

  set('/', '<plug>easymotion-sn',   'Search')
  set('n', '<plug>easymotion-next', 'Next result')
  set('N', '<plug>easymotion-prev', 'Previous result')

  set('a', '<plug>easymotion-jumptoanywhere', 'Jump to anywhere')

  set('f', '<plug>easymotion-bd-fl', 'Find line forward')
  set('F', '<plug>easymotion-bd-fl', 'Find line bidirectional')

  set('t', '<plug>easymotion-bd-tl', 'Til line forward')
  set('T', '<plug>easymotion-bd-Tl', 'Til line bidirectional')


  set('<up>',    '<plug>easymotion-k', '')
  set('<right>', '<plug>easymotion-linebackward', '')
  set('<down>',  '<plug>easymotion-j', '')
  set('<left>',  '<plug>easymotion-lineforward', '')


  set('SF', '<plug>easymotion-overwin-f2', '')

  set('Sf', '<plug>easymotion-overwin-f', '')

  set('Sl', '<plug>easymotion-overwin-line', '')

  set('Sw', '<plug>easymotion-overwin-w', '')



  set('ke', '<plug>easymotion-iskeyword-bd-e', '')

  set('kw', '<plug>easymotion-iskeyword-bd-w', '')




  set('sE', '<plug>easymotion-bd-e', '')


  set('sS', '<plug>easymotion-s', '')

  set('sW', '<plug>easymotion-bd-w', '')

  set('sa', '<plug>easymotion-lineanywhere', '')

  set('se', '<plug>easymotion-bd-el', '')

  set('sf', '<plug>easymotion-bd-f2', '')


  set('ss', '<plug>easymotion-s2', '')

  set('st', '<plug>easymotion-bd-t2', '')

  set('sw', '<plug>easymotion-bd-wl', '')

end
