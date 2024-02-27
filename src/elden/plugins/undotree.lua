return {
  'mbbill/undotree',

  init = function()
    local map = require'elden.cartographer'.map

    map(function()
      nx_leader_with 'f' {
        'u', exe 'UndotreeToggle', 'Undo tree'
      }
    end)
  end,
}