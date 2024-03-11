return {
  'danilamihailov/beacon.nvim',

  init = function(_)
    vim.keymap.set(
      { 'n', 'x' },
      'n',
      'nzzzv<cmd>Beacon<cr>',
      { desc = 'Next match and centre' }
    )

    vim.keymap.set(
      { 'n', 'x' },
      'N',
      'Nzzzv<cmd>Beacon<cr>',
      { desc = 'Previous match and centre' }
    )

    vim.keymap.set(
      { 'n', 'x' },
      '<leader>ke',
      '<cmd>BeaconToggle<cr>',
      { desc = 'Toggle beacon', noremap = true }
    )
  end,
}
