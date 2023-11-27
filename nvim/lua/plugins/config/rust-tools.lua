return function()
  local rust_tools = require'rust-tools'
  local map        = require'bundled.cartographer'.map

  local capabilities =
    require'cmp_nvim_lsp'
      .default_capabilities(vim.lsp.protocol.make_client_capabilities())

  rust_tools.setup({
    tools = {
      hover_actions = {
        auto_focus = true,
      },
    },

    server = {
      capabilities = capabilities,

      on_attach = function(_, bufnr)
        map(function()
          nx_local_leader_with 'r' {
            'a', rust_tools.code_action_group.code_action_group, 'Code actions',
            'h', rust_tools.hover_actions.hover_actions,         'Hover actions',
          }
        end)
      end
    },
  })
end
