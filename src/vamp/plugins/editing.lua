return {
  {
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
  },

  {
    'echasnovski/mini.nvim',
    version = false,
  },

  {
    'mbbill/undotree',

    keys = {
      {
        '<leader>nu',
        '<cmd>UndotreeToggle<cr>',
        desc = 'Undo tree',
      },
    },
  },

  {
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
  },
}
