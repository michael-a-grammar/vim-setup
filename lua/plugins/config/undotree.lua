return function()
  local map = require'elden.plugins.cartographer'.map

  map(function()
    nx_leader_with 'a' {
      'u', exe 'UndotreeToggle', 'Undo tree'
    }
  end)
end
