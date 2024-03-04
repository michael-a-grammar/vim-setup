return {
  'bfredl/nvim-miniyank',

  keys = {
    {
      '<leader>pu',
      '<plug>(miniyank-startput)',
      desc = 'Yank ring put',
      mode = { 'n', 'x' },
    },

    {
      '<leader>pU',
      '<plug>(miniyank-startPut)',
      desc = 'Yank ring Put',
      mode = { 'n', 'x' },
    },

    {
      '<leader>pn',
      '<plug>(miniyank-cycle)',
      desc = 'Yank ring cycle forwards',
      mode = { 'n', 'x' },
    },

    {
      '<leader>pp',
      '<plug>(miniyank-cycleback)',
      desc = 'Yank ring cycle backwards',
      mode = { 'n', 'x' },
    },
  },
}
