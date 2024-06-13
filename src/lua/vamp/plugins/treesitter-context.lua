return {
  'nvim-treesitter/nvim-treesitter-context',

  config = function()
    require('treesitter-context').setup()

    vim.keymap.set(
      { 'n', 'x' },
      '<leader>kc',
      '<cmd>TSContextToggle<cr>',
      { desc = 'Toggle treesitter context', noremap = true }
    )

    local catppuccin =
      require('catppuccin.palettes').get_palette(_G.catppuccin_theme)

    vim.api.nvim_set_hl(
      0,
      'TreesitterContextBottom',
      { sp = catppuccin.blue, underline = true }
    )
  end,
}
