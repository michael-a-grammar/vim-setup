return {
  'folke/trouble.nvim',
  dependencies = 'nvim-tree/nvim-web-devicons',

  opts = {
    action_keys = {
      hover = 'k',
      jump_close = 'g',
      next = 'p',
      open_code_href = 'c',
      open_split = 'h',
      open_tab = 't',
      open_vsplit = 'v',
      previous = 'f',
      switch_severity = 'w',
      toggle_mode = 'm',
      toggle_preview = 'o',
    },

    fold_closed = '',
    fold_open = '',
  },

  config = function(_, opts)
    local trouble = require('trouble')

    trouble.setup(opts)

    vim.keymap.set({ 'n', 'x' }, '<leader>gd', function()
      trouble.toggle('lsp_definitions')
    end, { desc = 'Definitions', noremap = true })

    vim.keymap.set({ 'n', 'x' }, 'gr', function()
      trouble.toggle('lsp_references')
    end, { desc = 'References', noremap = true })

    vim.keymap.set({ 'n', 'x' }, '<leader>dd', function()
      trouble.toggle('workspace_diagnostics')
    end, { desc = 'Workspace diagnostics', noremap = true })

    vim.keymap.set({ 'n', 'x' }, '<leader>dt', function()
      trouble.toggle('document_diagnostics')
    end, { desc = 'Document diagnostics', noremap = true })

    vim.keymap.set({ 'n', 'x' }, '<leader>ed', function()
      trouble.toggle('lsp_definitions')
    end, { desc = 'Definitions', noremap = true })

    vim.keymap.set({ 'n', 'x' }, '<leader>eu', function()
      trouble.toggle('lsp_references')
    end, { desc = 'References', noremap = true })

    vim.keymap.set({ 'n', 'x' }, '<leader>ey', function()
      trouble.toggle('lsp_type_definitions')
    end, { desc = 'Type definitions', noremap = true })

    vim.keymap.set({ 'n', 'x' }, '<leader>fl', function()
      trouble.toggle('loclist')
    end, { desc = 'Loclist', noremap = true })

    vim.keymap.set({ 'n', 'x' }, '<leader>fq', function()
      trouble.toggle('quickfix')
    end, { desc = 'Quickfix', noremap = true })

    vim.keymap.set({ 'n', 'x' }, '<leader>kt', function()
      trouble.toggle()
    end, { desc = 'Toggle trouble', noremap = true })
  end,
}
