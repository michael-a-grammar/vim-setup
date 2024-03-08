return {
  'gbprod/yanky.nvim',
  enabled = false,

  keys = {
    {
      '<leader>pg',
      '<plug>(YankyGPutAfter)',
      desc = 'Yank ring put and leave after cursor',
      mode = { 'n', 'x' },
    },

    {
      '<leader>pG',
      '<plug>(YankyGPutBefore)',
      desc = 'Yank ring put and leave before cursor',
      mode = { 'n', 'x' },
    },

    {
      '<leader>pn',
      '<plug>(YankyNextEntry)',
      desc = 'Yank ring next entry',
      mode = { 'n', 'x' },
    },

    {
      '<leader>pp',
      '<plug>(YankyPreviousEntry)',
      desc = 'Yank ring previous entry',
      mode = { 'n', 'x' },
    },

    {
      '<leader>pu',
      '<plug>(YankyPutAfter)',
      desc = 'Yank ring put after cursor',
      mode = { 'n', 'x' },
    },

    {
      '<leader>pU',
      '<plug>(YankyPutBefore)',
      desc = 'Yank ring put before cursor',
      mode = { 'n', 'x' },
    },

    opts = {
      ring = {
        storage = 'memory',
      },
    },
  },
}
