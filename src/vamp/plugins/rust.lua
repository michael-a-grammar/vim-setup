return {
  'simrat39/rust-tools.nvim',
  ft = 'rust',

  opts = function()
    local rust_tools = require('rust-tools')
    local map = require('vamp.cartographer').map

    local capabilities = require('cmp_nvim_lsp').default_capabilities(
      vim.lsp.protocol.make_client_capabilities()
    )

    return {
      tools = {
        hover_actions = {
          auto_focus = true,
        },
      },

      server = {
        capabilities = capabilities,

        on_attach = function(_, bufnr)
          local set_keymap = vim.keymap.set

          set_keymap(
            { 'n', 'x' },
            '<localleader>ra',
            rust_tools.code_action_group.code_action_group,
            { desc = 'Code actions', buffer = true, noremap = true }
          )

          set_keymap(
            { 'n', 'x' },
            '<localleader>rh',
            rust_tools.hover_actions.hover_actions,
            { desc = 'Hover actions', buffer = true, noremap = true }
          )
        end,
      },
    }
  end,
}
