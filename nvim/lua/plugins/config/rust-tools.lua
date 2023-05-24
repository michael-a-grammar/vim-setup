return function()
  local rust_tools   = require'rust-tools'
  local capabilities = require'cmp_nvim_lsp'.default_capabilities()
  local map          = require'bundled.cartographer'.map

  rust_tools.setup({
    server = {
      capabilities = capabilities,

      on_attach = function(_, bufnr)
        map(function()
          nx_local_leader_with 'r' {
            'a', rust_tools.code_action_group.code_action_group, 'Code actions',
            'h', rust_tools.hover_actions.hover_actions,         'Hover actions',
          }

          -- TODO: Move this
          local severity = {
            'error',
            'warn',
            'info',
            'info',
          }

          vim.lsp.handlers["window/showMessage"] = function(err, method, params, client_id)
            vim.notify(method.message, severity[params.type])
          end
        end)
      end
    }
  })
end
