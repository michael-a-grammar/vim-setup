return function()
  local set = require'milque.cartographer'.nx_leader_with('t')

  set('c', '<cmd>new<cr>',       'New buffer')
  set('d', '<cmd>bdelete<cr>',   'Delete buffer')
  set('n', '<cmd>bnext<cr>',     'Next buffer')
  set('p', '<cmd>bprevious<cr>', 'Previous buffer')
  set('w', '<cmd>bwall<cr>',     'Open buffers in windows')
  set('y', '<cmd>tab ball<cr>',  'Open buffers in tabs')
end
