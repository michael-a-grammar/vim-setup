return {
  'TimUntersberger/neogit',

  dependencies = {
    'nvim-lua/plenary.nvim',
    'sindrets/diffview.nvim',
    'nvim-telescope/telescope.nvim',
  },

  opts = {
    disable_hint = true,
    graph_style = 'unicode',
    signs = {
      section = { '', '' },
      item = { '󰄾', '󰄼' },
      hunk = { '', '' },
    },
    mappings = {
      commit_editor = {
        ['<c-c><c-d>'] = 'Abort',
        ['q'] = 'Close',
      },
      rebase_editor = {
        ['<c-c><c-d>'] = 'Abort',
        ['ge'] = 'MoveDown',
        ['gi'] = 'MoveUp',
      },
      finder = {
        ['<c-f>'] = 'Previous',
        ['<c-p>'] = 'Next',
      },
    },
  },

  config = function(_, opts)
    local set_keymap = vim.keymap.set
    local neogit = require('neogit')

    neogit.setup(opts)

    set_keymap(
      { 'n', 'x' },
      '<leader>g/',
      neogit.open,
      { desc = 'Neogit dispatch', noremap = true }
    )

    set_keymap({ 'n', 'x' }, '<leader>g?', function()
      neogit.open({ 'help' })
    end, { desc = 'Neogit help', noremap = true })

    set_keymap({ 'n', 'x' }, '<leader>ga', function()
      neogit.open({ 'cherry_pick' })
    end, { desc = 'Cherry Pick', noremap = true })

    set_keymap({ 'n', 'x' }, '<leader>gb', function()
      neogit.open({ 'branch' })
    end, { desc = 'Branch', noremap = true })

    set_keymap({ 'n', 'x' }, '<leader>gc', function()
      neogit.open({ 'commit' })
    end, { desc = 'Commit', noremap = true })

    set_keymap({ 'n', 'x' }, '<leader>gd', function()
      neogit.open({ 'diff' })
    end, { desc = 'Diff', noremap = true })

    set_keymap({ 'n', 'x' }, '<leader>ge', function()
      neogit.open({ 'remote' })
    end, { desc = 'Remote', noremap = true })

    set_keymap({ 'n', 'x' }, '<leader>gf', function()
      neogit.open({ 'fetch' })
    end, { desc = 'Fetch', noremap = true })

    set_keymap({ 'n', 'x' }, '<leader>gl', function()
      neogit.open({ 'log' })
    end, { desc = 'Log', noremap = true })

    set_keymap({ 'n', 'x' }, '<leader>gm', function()
      neogit.open({ 'merge' })
    end, { desc = 'Merge', noremap = true })

    set_keymap({ 'n', 'x' }, '<leader>gp', function()
      neogit.open({ 'pull' })
    end, { desc = 'Pull', noremap = true })

    set_keymap({ 'n', 'x' }, '<leader>gr', function()
      neogit.open({ 'rebase' })
    end, { desc = 'Rebase', noremap = true })

    set_keymap({ 'n', 'x' }, '<leader>gu', function()
      neogit.open({ 'push' })
    end, { desc = 'Push', noremap = true })

    set_keymap({ 'n', 'x' }, '<leader>gv', function()
      neogit.open({ 'revert' })
    end, { desc = 'Revert', noremap = true })

    set_keymap({ 'n', 'x' }, '<leader>gw', function()
      neogit.open({ 'worktree' })
    end, { desc = 'Worktree', noremap = true })

    set_keymap({ 'n', 'x' }, '<leader>gx', function()
      neogit.open({ 'reset' })
    end, { desc = 'Reset', noremap = true })

    set_keymap({ 'n', 'x' }, '<leader>gz', function()
      neogit.open({ 'Stash' })
    end, { desc = 'Stash', noremap = true })
  end,
}
