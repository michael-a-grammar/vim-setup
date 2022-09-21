return function()
  local map = require'milque.cartographer_new'.map

  map(function()
    nx_leader_with 'x' {
      'a', plug('EasyAlign'), 'Align'
    }
  end)
end
