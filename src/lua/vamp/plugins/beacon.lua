return {
  'danilamihailov/beacon.nvim',

  init = function(_)
    vim.keymap.set(
      { 'n', 'x' },
      'n',
      'n:Beacon<cr>',
      { desc = 'Next match and centre' }
    )

    vim.keymap.set(
      { 'n', 'x' },
      'N',
      'N:Beacon<cr>',
      { desc = 'Previous match and centre' }
    )

    vim.keymap.set(
      { 'n', 'x' },
      '<leader>ke',
      '<cmd>BeaconToggle<cr>',
      { desc = 'Toggle barbecue', noremap = true }
    )
  end,
}
