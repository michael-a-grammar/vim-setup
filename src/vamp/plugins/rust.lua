return {
  'simrat39/rust-tools.nvim',
  ft = 'rust',

  opts = function()
    local rust_tools = require('rust-tools')

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

        on_attach = function(_, _)
          vim.keymap.set(
            { 'n', 'x' },
            '<localleader>ra',
            rust_tools.code_action_group.code_action_group,
            { desc = 'Code actions', buffer = true, noremap = true }
          )

          vim.keymap.set(
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
