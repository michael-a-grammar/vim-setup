local map = require'milque.cartographer'.map

map(function()
  nx_leader {
    'l', exe('NERDTreeFind'),  'Open directory tree at current file',
    'L', exe('NERDTreeClose'), 'Close directory tree'
  }
end)
