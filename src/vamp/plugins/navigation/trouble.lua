return {
  {
    'folke/trouble.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',

    opts = {
      action_keys = {
        hover = 'k',
        jump_close = 'g',
        next = 'p',
        open_code_href = 'c',
        open_split = 's',
        open_tab = 't',
        open_vsplit = 'S',
        previous = 'n',
        switch_severity = 's',
        toggle_mode = 'm',
        toggle_preview = 'o',
      },

      fold_closed = '',
      fold_open = '', -- icon used for open folds
    },

    config = function(_, opts)
      local set_keymap = vim.keymap.set
      local trouble = require('trouble')

      trouble.setup(opts)

      set_keymap({ 'n', 'x' }, 'gr', function()
        trouble.toggle('lsp_references')
      end, { desc = 'References', noremap = true })

      set_keymap({ 'n', 'x' }, '<leader>dd', function()
        trouble.toggle('workspace_diagnostics')
      end, { desc = 'Workspace diagnostics', noremap = true })

      set_keymap({ 'n', 'x' }, '<leader>dt', function()
        trouble.toggle('document_diagnostics')
      end, { desc = 'Document diagnostics', noremap = true })

      set_keymap({ 'n', 'x' }, '<leader>ed', function()
        trouble.toggle('lsp_definitions')
      end, { desc = 'Definitions', noremap = true })

      set_keymap({ 'n', 'x' }, '<leader>eu', function()
        trouble.toggle('lsp_references')
      end, { desc = 'References', noremap = true })

      set_keymap({ 'n', 'x' }, '<leader>ey', function()
        trouble.toggle('lsp_definitions')
      end, { desc = 'Type definitions', noremap = true })

      set_keymap({ 'n', 'x' }, '<leader>fl', function()
        trouble.toggle('loclist')
      end, { desc = 'Loclist', noremap = true })

      set_keymap({ 'n', 'x' }, '<leader>fq', function()
        trouble.toggle('quickfix')
      end, { desc = 'Quickfix', noremap = true })

      set_keymap({ 'n', 'x' }, '<leader>te', function()
        trouble.toggle('document_diagnostics')
      end, { desc = 'Diagnostics', noremap = true })
    end,
  },
}
