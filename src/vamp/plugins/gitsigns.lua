return {
  'lewis6991/gitsigns.nvim',

  opts = {
    signs = {
      add = { text = '' },
      change = { text = '󰝤' },
      changedelete = { text = '󰝤' },
      delete = { text = '' },
      topdelete = { text = '' },
      untracked = { text = '󰝤' },
    },

    on_attach = function(_)
      local gitsigns = require('gitsigns')

      vim.keymap.set(
        { 'n', 'x' },
        '<leader>ngg',
        gitsigns.stage_hunk,
        { desc = 'Set loclist', noremap = true }
      )

      vim.keymap.set(
        'n',
        '<leader>ngr',
        gitsigns.reset_hunk,
        { desc = 'Reset hunk', noremap = true }
      )

      vim.keymap.set(
        'n',
        '<leader>ngs',
        gitsigns.stage_hunk,
        { desc = 'Stage hunk', noremap = true }
      )

      vim.keymap.set(
        { 'n', 'x' },
        '<leader>ngg',
        gitsigns.stage_hunk,
        { desc = 'Set quickfix', noremap = true }
      )
    end,
  },
}
