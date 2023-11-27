return function()
  local elixir    = require'elixir'
  local elixir_ls = require("elixir.elixirls")
  local map       = require'bundled.cartographer'.map

  local capabilities =
    require'cmp_nvim_lsp'
      .default_capabilities(vim.lsp.protocol.make_client_capabilities())

  elixir.setup {
    elixirls = {
      settings           = elixir_ls.settings {
        dialyzerEnabled  = true,
        enableTestLenses = true,
        fetchDeps        = true,
        suggestSpecs     = true,
      },

      on_attach = function(_, bufnr)
        map(function()
          nx_local_leader_with 'e' {
          }
        end)
      end
    },

    capabilities = capabilities,
  }
end
