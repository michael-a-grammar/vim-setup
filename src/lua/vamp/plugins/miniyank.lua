return {
  'bfredl/nvim-miniyank',
  enabled = false,

  keys = {
    {
      '<leader>pn',
      '<plug>(miniyank-cycle)',
      desc = 'Yank ring next entry',
      mode = { 'n', 'x' },
    },

    {
      '<leader>pp',
      '<plug>(miniyank-cycleback)',
      desc = 'Yank ring previous entry',
      mode = { 'n', 'x' },
    },

    {
      '<leader>pu',
      '<plug>(miniyank-startput)',
      desc = 'Yank ring put after cursor',
      mode = { 'n', 'x' },
    },

    {
      '<leader>pU',
      '<plug>(miniyank-startPut)',
      desc = 'Yank ring put before cursor',
      mode = { 'n', 'x' },
    },
  },
}
