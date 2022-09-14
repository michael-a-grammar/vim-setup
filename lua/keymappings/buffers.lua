return function()
  local set = require'milque.cartographer'.nx_leader_with't'

  set('c', '<cmd>new<cr>',           'New buffer')
  set('d', '<cmd>bdelete<cr>',       'Delete buffer')
  set('D', '<cmd>bufdo bdelete<cr>', 'Delete other buffers')
  set('n', '<cmd>bnext<cr>',         'Next buffer')
  set('p', '<cmd>bprevious<cr>',     'Previous buffer')
  set('w', '<cmd>vertical ball<cr>', 'Open buffers in vertical splits')
  set('W', '<cmd>ball<cr>',          'Open buffers in horizontal splits')
  set('y', '<cmd>tab ball<cr>',      'Open buffers in tabs')
end
