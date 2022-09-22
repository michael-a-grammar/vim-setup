return function()
  local map = require'milque.cartographer_new'.map

  map(function()
    nx_leader {
      'l', exe('NERDTreeFind'),  'Open directory tree at current file',
      'L', exe('NERDTreeClose'), 'Close directory tree'
    }
  end)
end
