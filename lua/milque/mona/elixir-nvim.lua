return function()
  local elixir = require'elixir'

  local capabilities =
    require'cmp_nvim_lsp'
      .update_capabilities(vim.lsp.protocol.make_client_capabilities())

  elixir.setup {
    settings           = elixir.settings {
      dialyzerEnabled  = true,
      enableTestLenses = true,
      fetchDeps        = true,
      suggestSpecs     = true
    },

    on_attach = function(client, buffer_number)
      require'lsp.keymappings'()
    end,

    capabilities = capabilities
  }
end
