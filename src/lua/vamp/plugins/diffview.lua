return {
  'sindrets/diffview.nvim',
  dependencies = 'nvim-tree/nvim-web-devicons',

  opts = {},

  config = function(opts, _)
    require('diffview').setup(opts)

    vim.keymap.set(
      { 'n', 'x' },
      '<leader>ngh',
      '<cmd>DiffviewFileHistory %<cr>',
      { desc = 'File history', noremap = true }
    )
  end,
}
