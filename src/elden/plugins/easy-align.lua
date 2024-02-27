return {
  'junegunn/vim-easy-align',

  init = function()
    local map = require'elden.cartographer'.map

    map(function()
      nx_leader_with 'x' {
        'a', plug 'EasyAlign', 'Align'
      }
    end)
  end,
}