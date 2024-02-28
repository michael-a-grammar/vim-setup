return {
  'terryma/vim-expand-region',

  keys = {
    {
      '<leader>ve',
      '<plug>(expand_region_expand)',
      desc = 'Expand region',
      mode = { 'n', 'x' },
    },

    {
      '<leader>vs',
      '<plug>(expand_region_shrink)',
      desc = 'Shrink region',
      mode = { 'n', 'x' },
    },
  },
}
