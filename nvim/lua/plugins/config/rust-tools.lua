return function()
  local lsp        = vim.lsp.buf
  local diagnostic = vim.diagnostic
  local rust_tools = require'rust-tools'
  local map        = require'bundled.cartographer'.map

  rust_tools.setup({
    tools = {
      inlay_hints = {
        auto                   = true,
        show_parameter_hints   = true,
        parameter_hints_prefix = '',
        other_hints_prefix     = '',
      },
    },

    server = {
      on_attach = function(_, bufnr)
        map(function()
          nx_local_leader_with 'r' {
            'a', rust_tools.code_action_group.code_action_group, 'Code actions',
            'h', rust_tools.hover_actions.hover_actions,         'Hover actions'
          }
        end)
      end
    }
  })
end
