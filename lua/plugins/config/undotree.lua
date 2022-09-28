return function()
  local map = require'milque.cartographer'.map

  map(function()
    nx_leader_with 'a' {
      'u', exe 'UndotreeToggle', 'Undo tree'
    }
  end)
end
