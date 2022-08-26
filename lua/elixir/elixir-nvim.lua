return function(opts)
  if opts.use.elixir_nvim and opts.use.cmp then
    local elixir = require'elixir'

    elixir.setup({
      settings           = elixir.settings({
        dialyzerEnabled  = false,
        enableTestLenses = false,
        fetchDeps        = false,
        suggestSpecs     = false
      }),

      on_attach = function(client, buffer_number)
        local map_opts = {
          buffer  = true,
          noremap = true
        }

        local capabilities =
          require('cmp_nvim_lsp')
            .update_capabilities(vim.lsp.protocol.make_client_capabilities())

        require('cmp_nvim_lsp').update_capabilities(capabilities)
      end
    })
  end
end
