return {
  'sindrets/diffview.nvim',

  opts = {},

  config = function(opts, _)
    vim.keymap.set(
      { 'n', 'x' },
      '<leader>ngh',
      '<cmd>DiffviewFileHistory %<cr>',
      { desc = 'File history', noremap = true }
    )
  end,
}
