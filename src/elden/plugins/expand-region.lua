return {
  'terryma/vim-expand-region',

  init = function()
    local map = require'elden.cartographer'.map

    map(function()
      nx_leader_with 'v' {
        'v', plug 'expand_region_expand', 'Expand region',
        'V', plug 'expand_region_shrink', 'Shrink region'
      }
    end)
  end,
}