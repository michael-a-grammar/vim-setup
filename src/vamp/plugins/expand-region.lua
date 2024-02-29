return {
  'terryma/vim-expand-region',

  keys = {
    {
      '<leader>pe',
      '<plug>(expand_region_expand)',
      desc = 'Expand region',
      mode = { 'n', 'x' },
    },

    {
      '<leader>ps',
      '<plug>(expand_region_shrink)',
      desc = 'Shrink region',
      mode = { 'n', 'x' },
    },
  },
}
