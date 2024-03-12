return {
  'folke/noice.nvim',
  event = 'VeryLazy',

  dependencies = {
    'MunifTanjim/nui.nvim',

    {
      'rcarriga/nvim-notify',
      opts = {
        render = 'default',
        stages = 'fade',
      },
    },
  },

  opts = {
    lsp = {
      override = {
        ['cmp.entry.get_documentation'] = true,
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
      },
    },

    presets = {
      bottom_search = true,
      command_palette = true,
      inc_rename = false,
      long_message_to_split = true,
      lsp_doc_border = true,
    },
  },

  config = function(_, opts)
    local noice = require('noice')

    noice.setup(opts)

    vim.keymap.set({ 'n', 'x' }, '<leader>aa', function()
      noice.cmd('dismiss')
    end, { desc = 'Dimiss notifications', noremap = true })

    vim.keymap.set({ 'n', 'x' }, '<leader>ae', function()
      noice.cmd('dismiss')
    end, { desc = 'Error notifications', noremap = true })

    vim.keymap.set({ 'n', 'x' }, '<leader>al', function()
      noice.cmd('last')
    end, { desc = 'Last notification', noremap = true })

    vim.keymap.set({ 'n', 'i', 's' }, '<c-f>', function()
      if not require('noice.lsp').scroll(-4) then
        return '<c-f>'
      end
    end, { desc = 'LSP hover doc scroll up', expr = true, silent = true })

    vim.keymap.set({ 'n', 'i', 's' }, '<c-p>', function()
      if not require('noice.lsp').scroll(4) then
        return '<c-p>'
      end
    end, { desc = 'LSP hover doc scroll down', expr = true, silent = true })
  end,
}
