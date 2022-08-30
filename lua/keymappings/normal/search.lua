return function()
  local set = require'milque.cartographer'.nx_leader_with'/'

  set('i', '<cmd>set noincsearch<cr>', 'Disable incremental search')
  set('t', '<cmd>nohlsearch<cr>',      'Disable highlighted search results')
end
