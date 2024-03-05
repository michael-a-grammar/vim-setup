return {
  'hedyhli/outline.nvim',
  lazy = true,

  cmd = {
    'Outline',
    'OutlineOpen',
  },

  keys = {
    {
      '<leader>noo',
      '<cmd>Outline<cr>',
      desc = 'Toggle and move to outline',
    },

    {
      '<leader>not',
      '<cmd>Outline!<cr>',
      desc = 'Toggle outline',
    },
  },

  opts = {
    keymaps = {
      down_and_jump = '<c-p>',
      fold = 'f',
      fold_all = 'M',
      hover_symbol = 'k',
      toggle_preview = 'p',
      unfold = 'u',
      unfold_all = 'R',
      up_and_jump = '<c-f>',
    },
  },
}
